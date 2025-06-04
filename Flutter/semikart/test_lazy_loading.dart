// Test script to verify lazy loading API calls
import 'dart:convert';
import 'dart:io';

void main() async {
  print('Testing Lazy Loading Implementation...');
  
  final client = HttpClient();
  const categoryId = 1; // Using categoryId 1 which has 8888+ products
  int totalProducts = 0;
  int currentPage = 1;
  int totalPages = 0;
  bool hasMoreData = true;
  
  try {
    // Test first few pages to simulate lazy loading
    while (hasMoreData && currentPage <= 3) {
      final uri = Uri.parse('http://172.16.2.5:8080/semikartapi/paginatedProductCatalog?categoryId=$categoryId&page=$currentPage&pageSize=20');
      
      print('\n--- Page $currentPage ---');
      print('Request: $uri');
      
      final request = await client.getUrl(uri);
      final response = await request.close();
      
      final responseBody = await response.transform(utf8.decoder).join();
      
      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        
        if (data['status'] == 'success' && data['products'] != null) {
          final products = data['products'] as List;
          totalPages = data['totalPages'] ?? 0;
          final totalResults = data['totalResults'] ?? 0;
          
          totalProducts += products.length;
          
          print('✅ Status: ${data['status']}');
          print('📦 Products in this page: ${products.length}');
          print('📊 Total products so far: $totalProducts');
          print('📄 Total pages available: $totalPages');
          print('🎯 Total results in category: $totalResults');
          
          if (products.isNotEmpty) {
            final sampleProduct = products.first;
            print('📱 Sample Product:');
            print('   PartNo: ${sampleProduct['PartNo']}');
            print('   Description: ${sampleProduct['description']}');
            print('   ImageUrl: ${sampleProduct['imageUrl']}');
          }
          
          hasMoreData = currentPage < totalPages;
          currentPage++;
        } else {
          print('❌ No products or unsuccessful status');
          hasMoreData = false;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        hasMoreData = false;
      }
      
      // Small delay to simulate real app usage
      await Future.delayed(Duration(milliseconds: 500));
    }
    
    print('\n🎉 Lazy Loading Test Summary:');
    print('✅ Total products loaded: $totalProducts');
    print('✅ Pages tested: ${currentPage - 1}');
    print('✅ Total pages available: $totalPages');
    print('✅ Lazy loading would work: ${totalPages > 1 ? "YES" : "NO"}');
    
  } catch (e) {
    print('❌ Error during test: $e');
  } finally {
    client.close();
  }
}
