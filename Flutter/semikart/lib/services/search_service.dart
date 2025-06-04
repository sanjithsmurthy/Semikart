import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CategoryResult {
  final String name;
  final String id;
  final int level; // 1 = L1, 2 = L2, 3 = L3
  CategoryResult({required this.name, required this.id, required this.level});
}

class SearchService {
  static const String baseUrl = 'http://172.16.2.5:8080/semikartapi/productHierarchy';

  // Caches
  List<Map<String, dynamic>>? _cachedL1;
  final Map<String, List<Map<String, dynamic>>> _cachedL2 = {};
  final Map<String, List<Map<String, dynamic>>> _cachedL3 = {};
  
  // Search result cache for lazy loading
  final Map<String, List<CategoryResult>> _searchCache = {};
  static const int maxCacheSize = 20;
  static const int maxResultsPerLevel = 20; // Limit results per level
  // Fetch L1 categories
  Future<List<Map<String, dynamic>>> fetchL1Categories() async {
    if (_cachedL1 != null) {
      log('Using cached L1 categories');
      return _cachedL1!;
    }
    
    log('Fetching L1 categories from API: $baseUrl');
    final response = await http.get(Uri.parse(baseUrl));
    log('L1 API response status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('L1 API response data: ${data.toString().substring(0, 200)}...');
      
      if (data['status'] == 'success' && data['mainCategories'] != null) {
        _cachedL1 = List<Map<String, dynamic>>.from(data['mainCategories']);
        log('Cached ${_cachedL1!.length} L1 categories');
        return _cachedL1!;
      }
    }
    log('Failed to fetch L1 categories');
    return [];
  }
  // Fetch L2 categories for a given L1 id
  Future<List<Map<String, dynamic>>> fetchL2Categories(String l1Id) async {
    if (_cachedL2.containsKey(l1Id)) {
      log('Using cached L2 categories for L1 ID: $l1Id');
      return _cachedL2[l1Id]!;
    }
    
    final url = '$baseUrl?main_category_id=$l1Id';
    log('Fetching L2 categories from: $url');
    final response = await http.get(Uri.parse(url));
    log('L2 API response status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success' && data['mainSubCategories'] != null) {
        final l2s = List<Map<String, dynamic>>.from(data['mainSubCategories']);
        _cachedL2[l1Id] = l2s;
        log('Cached ${l2s.length} L2 categories for L1 ID: $l1Id');
        return l2s;
      }
    }
    log('Failed to fetch L2 categories for L1 ID: $l1Id');
    return [];
  }

  // Fetch L3 categories for a given L2 id
  Future<List<Map<String, dynamic>>> fetchL3Categories(String l2Id) async {
    if (_cachedL3.containsKey(l2Id)) return _cachedL3[l2Id]!;
    final url = '$baseUrl?main_sub_categories=$l2Id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success' && data['categories'] != null) {
        final l3s = List<Map<String, dynamic>>.from(data['categories']);
        _cachedL3[l2Id] = l3s;
        return l3s;
      }
    }
    return [];
  }
  // Lazy loading search with early termination and substring matching
  Future<List<CategoryResult>> searchCategories(String keyword) async {
    // Check cache first
    if (_searchCache.containsKey(keyword.toLowerCase())) {
      log('Using cached search results for: $keyword');
      return _searchCache[keyword.toLowerCase()]!;
    }

    final lowerKeyword = keyword.toLowerCase().trim();
    if (lowerKeyword.isEmpty) return [];
    
    final List<CategoryResult> results = [];
    const int maxResults = 50; // Limit total results for performance
    
    log('Starting lazy search for substring: "$lowerKeyword"');
    
    // Step 1: Search L1 categories first
    final l1s = await fetchL1Categories();
    final List<String> promisingL1Ids = [];
    
    for (final l1 in l1s) {
      if (results.length >= maxResults) break; // Early termination
      
      final l1Name = (l1['name'] ?? l1['mainCategoryName'] ?? '').toString();
      final l1Id = (l1['id'] ?? l1['mainCategoryId'] ?? '').toString();
      
      // Exact substring matching (not individual characters)
      if (l1Name.toLowerCase().contains(lowerKeyword)) {
        results.add(CategoryResult(name: l1Name, id: l1Id, level: 1));
        promisingL1Ids.add(l1Id); // This L1 has matches, explore its children
        log('L1 match found: $l1Name');
      }
    }
    
    // Step 2: Lazy load L2 categories only for promising L1s or if no L1 matches
    if (results.length < maxResults) {
      List<String> l1IdsToSearch;
      
      if (promisingL1Ids.isNotEmpty) {
        // If we have L1 matches, only search their children
        l1IdsToSearch = promisingL1Ids;
        log('Searching L2 for ${promisingL1Ids.length} promising L1 categories');
      } else {
        // If no L1 matches, search first few L1s for L2 matches
        l1IdsToSearch = l1s.take(5).map((l1) => 
          (l1['id'] ?? l1['mainCategoryId'] ?? '').toString()
        ).where((id) => id.isNotEmpty).toList();
        log('No L1 matches, searching L2 for first ${l1IdsToSearch.length} L1 categories');
      }
      
      final List<String> promisingL2Ids = [];
      
      for (final l1Id in l1IdsToSearch) {
        if (results.length >= maxResults) break; // Early termination
        
        final l2s = await fetchL2Categories(l1Id);
        for (final l2 in l2s) {
          if (results.length >= maxResults) break;
          
          final l2Name = (l2['name'] ?? l2['mainSubCategoryName'] ?? '').toString();
          final l2Id = (l2['id'] ?? l2['mainSubCategoryId'] ?? '').toString();
          
          // Exact substring matching
          if (l2Name.toLowerCase().contains(lowerKeyword)) {
            results.add(CategoryResult(name: l2Name, id: l2Id, level: 2));
            promisingL2Ids.add(l2Id);
            log('L2 match found: $l2Name');
          }
        }
      }
      
      // Step 3: Lazy load L3 categories only for promising L2s
      if (results.length < maxResults && promisingL2Ids.isNotEmpty) {
        log('Searching L3 for ${promisingL2Ids.length} promising L2 categories');
        
        for (final l2Id in promisingL2Ids) {
          if (results.length >= maxResults) break; // Early termination
          
          final l3s = await fetchL3Categories(l2Id);
          for (final l3 in l3s) {
            if (results.length >= maxResults) break;
            
            final l3Name = (l3['name'] ?? l3['categoryName'] ?? '').toString();
            final l3Id = (l3['id'] ?? l3['categoryId'] ?? '').toString();
            
            // Exact substring matching
            if (l3Name.toLowerCase().contains(lowerKeyword)) {
              results.add(CategoryResult(name: l3Name, id: l3Id, level: 3));
              log('L3 match found: $l3Name');
            }
          }
        }
      }
    }
    
    // Cache the results
    if (_searchCache.length >= maxCacheSize) {
      final oldestKey = _searchCache.keys.first;
      _searchCache.remove(oldestKey);
    }
    _searchCache[lowerKeyword] = results;
    
    log('Search completed. Found ${results.length} results for "$keyword"');
    return results;
  }
  
  // Clear search cache
  void clearSearchCache() {
    _searchCache.clear();
    log('Search cache cleared');
  }
}