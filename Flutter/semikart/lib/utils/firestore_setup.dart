// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firestore_helper.dart'; // Import the FirestoreHelper

// class FirestoreSetup {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> setupDatabase() async {
//     // Example: Adding a User
//     await _firestore.collection('users').doc('uid_123').set({
//       'name': 'John Doe',
//       'email': 'johndoe@example.com',
//       'phone': '+1234567890',
//       'role': 'buyer', // or 'seller'
//     });

//     // Example: Adding a Buyer Role Access
//     await _firestore.collection('buyerRoleAccess').doc('access_001').set({
//       'userId': 'uid_123',
//       'role': 'buyer',
//       'permissions': ['view_products', 'place_orders'],
//     });

//     // Example: Adding a Category
//     await _firestore.collection('categories').doc('cat_electronics').set({
//       'name': 'Electronics',
//       'description': 'Various electronic gadgets and devices',
//     });

//     // Example: Adding Subcategories Using FirestoreHelper
//     await FirestoreHelper.addMultipleL2Categories(
//       l1Id: 'cat_electronics',
//       names: ['Mobile Phones', 'Laptops', 'Tablets'],
//     );

//     // Example: Adding a Product
//     await _firestore.collection('products').doc('prod_456').set({
//       'name': 'iPhone 13',
//       'price': 999.99,
//       'categoryId': 'cat_electronics',
//       'stock': 50,
//     });

//     // Example: Adding Sample Data Using FirestoreHelper
//     await FirestoreHelper.addSampleData();
//   }
// }