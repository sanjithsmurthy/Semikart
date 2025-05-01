import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  // Collection reference for products
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  // Collection reference for L1 products
  final CollectionReference l1ProductsCollection =
      FirebaseFirestore.instance.collection('l1_products');

  // Method to update user data
  Future updateUserData(String email, String firstname, String lastname, String phone, String password) async {
    return await productCollection.add({
      'first_name': firstname,
      'last_name': lastname,
      'phone': phone,
      'password': password,
      'email': email,
    });
  }

  // Method to upload L1 product data
  Future<void> uploadL1ProductData(String name, String iconUrl) async {
    try {
      await l1ProductsCollection.add({
        'name': name, // Dynamic product name
        'icon': iconUrl, // Dynamic Google Drive link
      });
      print('L1 product uploaded: $name');
    } catch (e) {
      print('Error uploading L1 product: $e');
    }
  }

  // Method to upload all 17 L1 products
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

    for (var product in l1Products) {
      await uploadL1ProductData(product['name']!, product['icon']!);
    }
    print('All L1 products uploaded successfully!');
  }
}

// Automatically trigger the upload when this file is executed
void main() async {
  final databaseService = DataBaseService();
  await databaseService.uploadAllL1Products();
}