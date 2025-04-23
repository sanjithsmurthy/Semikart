import 'package:flutter/foundation.dart';

@immutable // Good practice for model classes used in state management
class CartItemModel {
  // Unique identifier combining product and supplier
  final String id;
  final String mfrPartNumber;
  final String customerPartNumber;
  final String description;
  final String vendorPartNumber;
  final String manufacturer;
  final String supplier;
  final double basicUnitPrice; // Price per unit for the *current quantity*
  final double finalUnitPrice; // Price per unit including potential markups (if any)
  final double gstPercentage;
  final int quantity;
  // Optional: Add fields like imageUrl if needed in the cart display
  // final String? imageUrl;

  CartItemModel({
    required this.mfrPartNumber,
    required this.customerPartNumber,
    required this.description,
    required this.vendorPartNumber,
    required this.manufacturer,
    required this.supplier,
    required this.basicUnitPrice,
    required this.finalUnitPrice,
    required this.gstPercentage,
    required this.quantity,
    // this.imageUrl,
  }) : id = '${mfrPartNumber}_${supplier}'; // Create a unique ID

  // --- Methods for potential immutability/updates ---

  CartItemModel copyWith({
    int? quantity,
    double? basicUnitPrice,
    double? finalUnitPrice,
  }) {
    return CartItemModel(
      mfrPartNumber: mfrPartNumber,
      customerPartNumber: customerPartNumber,
      description: description,
      vendorPartNumber: vendorPartNumber,
      manufacturer: manufacturer,
      supplier: supplier,
      basicUnitPrice: basicUnitPrice ?? this.basicUnitPrice,
      finalUnitPrice: finalUnitPrice ?? this.finalUnitPrice,
      gstPercentage: gstPercentage,
      quantity: quantity ?? this.quantity,
      // imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // --- Equality and HashCode ---
  // Necessary for comparing items, e.g., in lists or sets

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id; // Primarily compare by unique ID

  @override
  int get hashCode => id.hashCode;


  // --- Optional: JSON Serialization (if needed for storage/API) ---

  // factory CartItemModel.fromJson(Map<String, dynamic> json) { ... }
  // Map<String, dynamic> toJson() { ... }

}