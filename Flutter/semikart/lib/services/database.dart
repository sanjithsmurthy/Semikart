import 'package:dio/dio.dart';
import 'dart:developer';
import '../config/api_config.dart';  // Add this import
import 'api_client.dart';  // Add this import

class DataBaseService {
  final ApiClient _apiClient = ApiClient();
  
  // Keep the baseUrl reference for backward compatibility
  final String baseUrl = ApiConfig.baseUrl;
  
  DataBaseService() {
    // No need to configure Dio here as it's handled by ApiClient
  }

  // Method to update user data
  Future<dynamic> updateUserData(String email, String firstname, String lastname, String phone, String password) async {
    try {
      final endpoint = Users.profile('update'); // Using Users class directly
      final formData = FormData.fromMap({
        'email': email,
        'first_name': firstname,
        'last_name': lastname,
        'phone': phone,
        'password': password,
      });
      
      final response = await _apiClient.dio.post(endpoint, data: formData, options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}));
      log('User data updated for $email');
      return response.data;
    } catch (e) {
      log('Error updating user data: $e');
      rethrow;
    }
  }

  // Method to upload L1 product data
  Future<void> uploadL1ProductData(String name, String iconUrl) async {
    try {
      final endpoint = Categories.l1Add; // Using Categories class directly
      final formData = FormData.fromMap({
        'name': name,
        'icon': iconUrl,
      });
      
      await _apiClient.dio.post(endpoint, data: formData, options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}));
      log('L1 product uploaded: $name');
    } catch (e) {
      log('Error uploading L1 product: $e');
      rethrow;
    }
  }

  // Method to upload all 17 L1 products (keeping existing functionality)
  Future<void> uploadAllL1Products() async {
    final List<Map<String, String>> l1Products = [
      {
        "name": "Circuit Protection",
        "icon": "https://drive.google.com/file/d/1kPNfUxKxSCy85qIilEnAIfvOeeCeBIPo/view?usp=sharing"
      },
      {
        "name": "Connectors",
        "icon": "https://drive.google.com/file/d/1myYF8oVz23O5ZuRk10Q4inRZIFSVxnvc/view?usp=sharing"
      },
      {
        "name": "Electromechanical",
        "icon": "https://drive.google.com/file/d/14A3VEH2JMWyTeEDFJW6gSxyoH1ggE-bi/view?usp=sharing"
      },
      {
        "name": "Embedded Solutions",
        "icon": "https://drive.google.com/file/d/1c4Sl8YXhrV7uhJDL5yOsVQcyAL0ABSXC/view?usp=sharing"
      },
      {
        "name": "Enclosures",
        "icon": "https://drive.google.com/file/d/1i_FMq5KyDftY4NYy4okIoTPWEmtUVfRf/view?usp=sharing"
      },
      {
        "name": "Engineering Development Tools",
        "icon": "https://drive.google.com/file/d/1gPTJsCQZ0Y5CmHQuin-7EAQdh2Enmvk_/view?usp=sharing"
      },
      {
        "name": "Industrial Automation",
        "icon": "https://drive.google.com/file/d/1_Ci8OnPWJUxBbF89Hir5btiqo4QfClZb/view?usp=sharing"
      },
      {
        "name": "LED Lighting",
        "icon": "https://drive.google.com/file/d/1n9bmdbDtZZPPstxNw_Uw896_371TRnDn/view?usp=sharing"
      },
      {
        "name": "Optoelectronics",
        "icon": "https://drive.google.com/file/d/1uKYxUmsl1RTy_EKoxiyCLUz3S1W0_vkm/view?usp=sharing"
      },
      {
        "name": "Passive Components",
        "icon": "https://drive.google.com/file/d/1XkvJvB28OJR3C4OksuD1b_BNMD0rL9iU/view?usp=sharing"
      },
      {
        "name": "Power",
        "icon": "https://drive.google.com/file/d/14JEgA1w0zJnShSATy63f5HG5ZrL9Ajuf/view?usp=sharing"
      },
      {
        "name": "Semiconductors",
        "icon": "https://drive.google.com/file/d/1m4-50bIa-vOA0v5TOhuBEP22rVyUvxkX/view?usp=sharing"
      },
      {
        "name": "Sensors",
        "icon": "https://drive.google.com/file/d/11tOiYd4hTFvwzc4jBsb2XhNsJdJ53o8i/view?usp=sharing"
      },
      {
        "name": "Test and Measurements",
        "icon": "https://drive.google.com/file/d/10LbnfkRw6IFmykpULoq34BcTC6y7b1Io/view?usp=sharing"
      },
      {
        "name": "Thermal Management",
        "icon": "https://drive.google.com/file/d/1xfc59WlR5IDD4bHhxCt9ybb75sEVRlYi/view?usp=sharing"
      },
      {
        "name": "Tools and Suppliers",
        "icon": "https://drive.google.com/file/d/12pcS_K6iqk8vXWK7nLeLZfnvhLuHlGQe/view?usp=sharing"
      },
      {
        "name": "Wire Cables",
        "icon": "https://drive.google.com/file/d/1-_fnitbr5kyl6dJ6VB4gHjOLhXRjegVk/view?usp=sharing"
      },
    ];

    // Option 1: Upload one by one
    for (var product in l1Products) {
      await uploadL1ProductData(product['name']!, product['icon']!);
    }
    log('All L1 products uploaded successfully!');
  }
  
  // Method to get all L1 products - updated with ApiClient
  Future<List<Map<String, dynamic>>> getL1Products() async {
    try {
      final endpoint = Categories.l1List; // Using Categories class directly
      final response = await _apiClient.dio.get(endpoint, options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}));
      
      final List<dynamic> data = response.data;
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching L1 products: $e');
      rethrow;
    }
  }
  
  // Method to get product details - updated with ApiClient
  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    try {
      final endpoint = Products.details(productId); // Using Products class method directly
      final response = await _apiClient.dio.get(endpoint, options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}));
      return response.data;
    } catch (e) {
      log('Error fetching product details for $productId: $e');
      rethrow;
    }
  }
  
  // Method to add a single L2 category - updated with ApiClient
  Future<void> addL2Category({required String l1Id, required String name}) async {
    try {
      final endpoint = Categories.l2Add; // Using Categories class directly
      final formData = FormData.fromMap({
        'name': name,
        'l1id': l1Id,
      });
      
      final response = await _apiClient.dio.post(endpoint, data: formData, options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}));
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add L2 category: ${response.statusMessage}');
      }
      
      log('Added L2 category: $name under L1 ID: $l1Id');
    } catch (e) {
      log('Error adding L2 category: $e');
      rethrow;
    }
  }
  
  // Method for bulk adding L2 categories - updated with ApiClient
  Future<void> addMultipleL2Categories({required String l1Id, required List<String> names}) async {
    try {
      // Keep using full URL for endpoints not defined in ApiConfig
      final endpoint = '$baseUrl/products/l2/bulk';
      final data = names.map((name) => {
        'name': name,
        'l1id': l1Id,
      }).toList();
      
      final response = await _apiClient.dio.post(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
        data: data,
      );
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add L2 categories in bulk: ${response.statusMessage}');
      }
      
      log('Added ${names.length} L2 categories under L1 ID: $l1Id');
    } catch (e) {
      log('Error adding multiple L2 categories: $e');
      rethrow;
    }
  }

  // Get L2 categories for a specific L1 category - updated with ApiClient
  Future<List<Map<String, dynamic>>> getL2ProductsByL1Id(String l1Id) async {
    try {
      final endpoint = Categories.l2List; // Using Categories class directly
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
        queryParameters: {'l1id': l1Id}
      );
      
      final List<dynamic> data = response.data;
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching L2 products for L1 ID $l1Id: $e');
      rethrow;
    }
  }

  // Add L3 category linked to an L2 category - updated with ApiClient
  Future<void> addL3Category({required String l2Id, required String name}) async {
    try {
      final endpoint = Categories.l3Add; // Using Categories class directly
      final formData = FormData.fromMap({
        'name': name,
        'l2id': l2Id,
      });
      
      final response = await _apiClient.dio.post(endpoint, data: formData, options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}));
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add L3 category: ${response.statusMessage}');
      }
      
      log('Added L3 category: $name under L2 ID: $l2Id');
    } catch (e) {
      log('Error adding L3 category: $e');
      rethrow;
    }
  }

  // Get L3 products for a specific L2 category - updated with ApiClient
  Future<List<Map<String, dynamic>>> getL3ProductsByL2Id(String l2Id) async {
    try {
      final endpoint = Categories.l3List; // Using Categories class directly
      final response = await _apiClient.dio.get(
        endpoint, 
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
        queryParameters: {'l2id': l2Id}
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch L3 products: ${response.statusMessage}');
      }
      
      final List<dynamic> data = response.data;
      log('Fetched ${data.length} L3 products for L2 ID: $l2Id');
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching L3 products for L2 ID $l2Id: $e');
      rethrow;
    }
  }
}

// Main function can be used for testing
void main() async {
  final databaseService = DataBaseService();
  // Comment this out in production - only uncomment when you want to upload all products
  // await databaseService.uploadAllL1Products();
  
  // Test fetching products
  try {
    final products = await databaseService.getL1Products();
    log('Fetched ${products.length} L1 products');
    for (var product in products) {
      log('Product: ${product['name']}');
    }
  } catch (e) {
    log('Error in main: $e');
  }
}