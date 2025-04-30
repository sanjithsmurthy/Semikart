import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSetup {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setupDatabase() async {
    // Example: Adding a User
    await _firestore.collection('users').doc('uid_123').set({
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'phone': '+1234567890',
      'role': 'buyer', // or 'seller'
    });

    // Example: Adding a Buyer Role Access
    await _firestore.collection('buyerRoleAccess').doc('access_001').set({
      'userId': 'uid_123',
      'role': 'buyer',
      'permissions': ['view_products', 'place_orders'],
    });

    // Example: Adding a Category
    await _firestore.collection('categories').doc('cat_electronics').set({
      'name': 'Electronics',
      'description': 'Various electronic gadgets and devices',
    });

    // Example: Adding a Sub-Category (Nested under Categories)
    await _firestore
        .collection('categories')
        .doc('cat_electronics')
        .collection('subCategories')
        .doc('sub_mobiles')
        .set({
      'name': 'Mobile Phones',
      'categoryId': 'cat_electronics',
    });

    // Example: Adding a Product
    await _firestore.collection('products').doc('prod_456').set({
      'name': 'iPhone 13',
      'price': 999.99,
      'categoryId': 'cat_electronics',
      'stock': 50,
    });

    // Example: Adding a Cart (Nested under Users or Root Collection)
    await _firestore.collection('carts').doc('cart_789').set({
      'userId': 'uid_123', // Replace with dynamic user ID
      'productId': 'prod_456', // Replace with dynamic product ID
      'quantity': 1,
      'mfrPartNumber': 'LSP4-480',
      'customerPartNumber': 'Customer Part',
      'description': 'LED Protection Devices\nLED Protection Devices, 120VAC-480VAC, 10kA/20kA, Compact Design',
      'vendorPartNumber': '837-LSP4-480',
      'manufacturer': 'Hatch Lighting',
      'supplier': 'Mouser Electronics',
      'basicUnitPrice': 911.93,
      'finalUnitPrice': 1103.3441,
      'gstPercentage': 18.0,
    });

    // Example: Adding an Order
    await _firestore.collection('orders').doc('order_101').set({
      'userId': 'uid_123',
      'status': 'Pending',
      'totalAmount': 1999.98,
      'createdAt': Timestamp.now(),
    });

    // Example: Adding Order History (Nested under Orders)
    await _firestore
        .collection('orders')
        .doc('order_101')
        .collection('orderHistory')
        .doc('history_102')
        .set({
      'orderId': 'order_101',
      'status': 'Shipped',
      'updatedAt': Timestamp.now(),
    });

    // Example: Adding Order Details (Nested under Orders)
    await _firestore
        .collection('orders')
        .doc('order_101')
        .collection('orderDetails')
        .doc('detail_103')
        .set({
      'orderId': 'order_101',
      'productId': 'prod_456',
      'quantity': 2,
      'price': 999.99,
    });

    // Example: Adding Order Tracking (Nested under Orders)
    await _firestore
        .collection('orders')
        .doc('order_101')
        .collection('orderTracking')
        .doc('track_104')
        .set({
      'orderId': 'order_101',
      'status': 'Out for Delivery',
      'location': 'Warehouse A',
      'updatedAt': Timestamp.now(),
    });

    // Example: Adding an RFQ
    await _firestore.collection('rfqs').doc('rfq_105').set({
      'userId': 'uid_123',
      'productId': 'prod_456',
      'quantity': 10,
      'status': 'Pending',
      'requestedAt': Timestamp.now(),
    });
  }
}