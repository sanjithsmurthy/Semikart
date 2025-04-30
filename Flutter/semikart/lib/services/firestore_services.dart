import 'package:cloud_firestore/cloud_firestore.dart';

 class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch L1 Categories
  Future<List<Map<String, dynamic>>> fetchL1Categories() async {
    final snapshot = await _firestore
        .collection('categories')
        .where('parentCategoryId', isNull: true) // L1 categories have no parent
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Fetch L2 Categories for an L1 Category
  Future<List<Map<String, dynamic>>> fetchL2Categories(String l1CategoryId) async {
    final snapshot = await _firestore
        .collection('categories')
        .where('parentCategoryId', isEqualTo: l1CategoryId) // L2 categories have L1 as parent
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Fetch L3 Categories for an L2 Category
  Future<List<Map<String, dynamic>>> fetchL3Categories(String l2CategoryId) async {
    final snapshot = await _firestore
        .collection('categories')
        .where('parentCategoryId', isEqualTo: l2CategoryId) // L3 categories have L2 as parent
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Fetch Products for an L3 Category
  Future<List<Map<String, dynamic>>> fetchProducts(String l3CategoryId) async {
    final snapshot = await _firestore
        .collection('products')
        .where('categoryId', isEqualTo: l3CategoryId) // Products belong to an L3 category
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Fetch Product Details
  Future<Map<String, dynamic>> fetchProductDetails(String productId) async {
    final productSnapshot = await _firestore
        .collection('products')
        .doc(productId)
        .get();

    final productData = productSnapshot.data();

    if (productData != null) {
      final skuSnapshot = await _firestore
          .collection('skus')
          .doc(productData['defaultSkuId'])
          .get();

      final skuData = skuSnapshot.data();

      return {
        ...productData,
        'price': skuData?['price'],
        'quantity': skuData?['quantity'],
      };
    }

    throw Exception('Product not found');
  }
}