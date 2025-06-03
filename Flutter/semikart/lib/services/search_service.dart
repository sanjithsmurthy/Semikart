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

  // Dynamic search across L1, L2, L3
  Future<List<CategoryResult>> searchCategories(String keyword) async {
    final lowerKeyword = keyword.toLowerCase();
    final List<CategoryResult> results = [];
    // L1
    final l1s = await fetchL1Categories();
    for (final l1 in l1s) {
      final l1Name = l1['name'] ?? l1['mainCategoryName'] ?? '';
      final l1Id = l1['id'] ?? l1['mainCategoryId']?.toString() ?? '';
      if (l1Name.toLowerCase().contains(lowerKeyword)) {
        results.add(CategoryResult(name: l1Name, id: l1Id, level: 1));
      }
      // L2
      final l2s = await fetchL2Categories(l1Id);
      for (final l2 in l2s) {
        final l2Name = l2['name'] ?? l2['mainSubCategoryName'] ?? '';
        final l2Id = l2['id'] ?? l2['mainSubCategoryId']?.toString() ?? '';
        if (l2Name.toLowerCase().contains(lowerKeyword)) {
          results.add(CategoryResult(name: l2Name, id: l2Id, level: 2));
        }
        // L3
        final l3s = await fetchL3Categories(l2Id);
        for (final l3 in l3s) {
          final l3Name = l3['name'] ?? l3['categoryName'] ?? '';
          final l3Id = l3['id'] ?? l3['categoryId']?.toString() ?? '';
          if (l3Name.toLowerCase().contains(lowerKeyword)) {
            results.add(CategoryResult(name: l3Name, id: l3Id, level: 3));
          }
        }
      }
    }
    return results;
  }
}