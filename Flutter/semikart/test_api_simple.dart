import 'dart:convert';
import 'dart:io';

void main() async {
  print('Testing L4 API endpoint...');
  
  // Test the productCatalog endpoint with various category IDs
  final testCategoryIds = [1, 2, 3, 4, 5, 10, 15, 20];
  
  final client = HttpClient();
  
  for (final categoryId in testCategoryIds) {
    try {
      final uri = Uri.parse('http://172.16.2.5:8080/semikartapi/paginatedProductCatalog?categoryId=$categoryId&page=1&pageSize=5');
      final request = await client.getUrl(uri);
      final response = await request.close();
      
      final responseBody = await response.transform(utf8.decoder).join();
      
      print('CategoryId $categoryId:');
      print('  Status: ${response.statusCode}');
      print('  Response: $responseBody');
      
      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(responseBody);
          if (data is Map<String, dynamic> && data['products'] != null) {
            final products = data['products'] as List;
            print('  Products found: ${products.length}');
            if (products.isNotEmpty) {
              print('  Sample product keys: ${(products.first as Map).keys.toList()}');
            }
          }
        } catch (e) {
          print('  JSON parse error: $e');
        }
      }
      print('  ---');
    } catch (e) {
      print('CategoryId $categoryId - Error: $e');
      print('  ---');
    }
  }
  
  client.close();
  print('API test completed.');
}
