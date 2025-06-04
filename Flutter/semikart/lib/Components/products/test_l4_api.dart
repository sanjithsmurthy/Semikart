import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

// Test function to verify L4 API endpoint independently
Future<void> testL4API() async {
  // Test with a sample category ID (you might need to use a valid one from your L3 categories)
  final testCategoryIds = [1, 2, 3, 4, 5]; // Test multiple IDs
  
  for (final categoryId in testCategoryIds) {
    log('Testing L4 API with categoryId: $categoryId');
    
    final url = Uri.parse('http://172.16.2.5:8080/semikartapi/paginatedProductCatalog?categoryId=$categoryId&page=1&pageSize=10');
    
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      
      log('Response for categoryId $categoryId:');
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Parsed JSON: $data');
        
        if (data is Map<String, dynamic>) {
          log('Status: ${data['status']}');
          log('Has products: ${data.containsKey('products')}');
          
          if (data['products'] != null) {
            final products = data['products'] as List;
            log('Products count: ${products.length}');
            
            if (products.isNotEmpty) {
              log('First product structure: ${products.first}');
            }
          }
        }
      }
      
      log('-------------------');
    } catch (e) {
      log('Error testing categoryId $categoryId: $e');
      log('-------------------');
    }
  }
}

// Test function specifically to check what category IDs are available
Future<void> testAvailableCategoryIds() async {
  log('Testing available category IDs from L3 hierarchy...');
  
  // First get L1 categories
  final l1Url = Uri.parse('http://172.16.2.5:8080/semikartapi/productHierarchy');
  
  try {
    final l1Response = await http.get(l1Url).timeout(const Duration(seconds: 30));
    
    if (l1Response.statusCode == 200) {
      final l1Data = jsonDecode(l1Response.body);
      
      if (l1Data['status'] == 'success' && l1Data['mainCategories'] != null) {
        final l1Categories = l1Data['mainCategories'] as List;
        
        for (final l1Cat in l1Categories.take(2)) { // Test first 2 L1 categories
          final l1Id = l1Cat['mainCategoryId'];
          log('Testing L1 Category: ${l1Cat['mainCategoryName']} (ID: $l1Id)');
          
          // Get L2 categories for this L1
          final l2Url = Uri.parse('http://172.16.2.5:8080/semikartapi/productHierarchy?main_category_id=$l1Id');
          
          try {
            final l2Response = await http.get(l2Url).timeout(const Duration(seconds: 30));
            
            if (l2Response.statusCode == 200) {
              final l2Data = jsonDecode(l2Response.body);
              
              if (l2Data['status'] == 'success' && l2Data['mainSubCategories'] != null) {
                final l2Categories = l2Data['mainSubCategories'] as List;
                
                for (final l2Cat in l2Categories.take(1)) { // Test first L2 category
                  final l2Id = l2Cat['subCategoryId'];
                  log('  Testing L2 Category: ${l2Cat['subCategoryName']} (ID: $l2Id)');
                  
                  // Get L3 categories for this L2
                  final l3Url = Uri.parse('http://172.16.2.5:8080/semikartapi/productHierarchy?main_sub_category_id=$l2Id');
                  
                  try {
                    final l3Response = await http.get(l3Url).timeout(const Duration(seconds: 30));
                    
                    if (l3Response.statusCode == 200) {
                      final l3Data = jsonDecode(l3Response.body);
                      
                      if (l3Data['status'] == 'success' && l3Data['categories'] != null) {
                        final l3Categories = l3Data['categories'] as List;
                        
                        for (final l3Cat in l3Categories.take(1)) { // Test first L3 category
                          final l3Id = l3Cat['categoryId'];
                          log('    Testing L3 Category: ${l3Cat['categoryName']} (ID: $l3Id)');
                          
                          // Now test the productCatalog API with this valid L3 category ID
                          await testProductCatalogForCategory(l3Id);
                        }
                      }
                    }
                  } catch (e) {
                    log('    Error fetching L3 for L2 $l2Id: $e');
                  }
                }
              }
            }
          } catch (e) {
            log('  Error fetching L2 for L1 $l1Id: $e');
          }
        }
      }
    }
  } catch (e) {
    log('Error fetching L1 categories: $e');
  }
}

Future<void> testProductCatalogForCategory(int categoryId) async {
  log('      Testing productCatalog for categoryId: $categoryId');
  
  final url = Uri.parse('http://172.16.2.5:8080/semikartapi/paginatedProductCatalog?categoryId=$categoryId&page=1&pageSize=5');
  
  try {
    final response = await http.get(url).timeout(const Duration(seconds: 30));
    
    log('      ProductCatalog Response:');
    log('      Status Code: ${response.statusCode}');
    log('      Response Body: ${response.body}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data is Map<String, dynamic>) {
        log('      Status: ${data['status']}');
        log('      Has products: ${data.containsKey('products')}');
        
        if (data['products'] != null) {
          final products = data['products'] as List;
          log('      Products count: ${products.length}');
          
          if (products.isNotEmpty) {
            log('      Sample product: ${products.first}');
            log('      SUCCESS: Found products for categoryId $categoryId');
          } else {
            log('      No products found for categoryId $categoryId');
          }
        } else {
          log('      No products key in response for categoryId $categoryId');
        }
      }
    } else {
      log('      HTTP Error ${response.statusCode} for categoryId $categoryId');
    }
  } catch (e) {
    log('      Exception for categoryId $categoryId: $e');
  }
  
  log('      ========================');
}
