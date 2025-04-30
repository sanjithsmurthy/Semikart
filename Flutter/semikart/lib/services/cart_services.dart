import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Item to Cart
  Future<void> addToCart(
      String userId,
      String productId,
      String mfrPartNumber,
      String customerPartNumber,
      String description,
      String vendorPartNumber,
      String manufacturer,
      String supplier,
      double basicUnitPrice,
      double finalUnitPrice,
      double gstPercentage,
      int quantity) async {
    await _firestore.collection('carts').doc('$userId-$productId').set({
      'userId': userId,
      'productId': productId,
      'mfrPartNumber': mfrPartNumber,
      'customerPartNumber': customerPartNumber,
      'description': description,
      'vendorPartNumber': vendorPartNumber,
      'manufacturer': manufacturer,
      'supplier': supplier,
      'basicUnitPrice': basicUnitPrice,
      'finalUnitPrice': finalUnitPrice,
      'gstPercentage': gstPercentage,
      'quantity': quantity,
    });
  }

  // Update Cart Item
  Future<void> updateCartItem(
      String userId,
      String productId,
      int quantity,
      {double? finalUnitPrice}) async {
    final data = {
      'quantity': quantity,
    };
    if (finalUnitPrice != null) {
      data['finalUnitPrice'] = finalUnitPrice;
    }
    await _firestore.collection('carts').doc('$userId-$productId').update(data);
  }

  // Fetch Cart Items
  Stream<QuerySnapshot> fetchCartItems(String userId) {
    return _firestore
        .collection('carts')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  // Remove Item from Cart
  Future<void> removeFromCart(String userId, String productId) async {
    await _firestore.collection('carts').doc('$userId-$productId').delete();
  }

  // Clear Cart
  Future<void> clearCart(String userId) async {
    final cartItems = await _firestore
        .collection('carts')
        .where('userId', isEqualTo: userId)
        .get();
    for (var doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }
}