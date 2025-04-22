import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart'; // Import for firstWhereOrNull
import '../models/cart_item_model.dart';

class CartManager extends ChangeNotifier {
  final Map<String, CartItemModel> _items = {}; // Use Map for easy access by ID

  // --- Getters ---

  /// Returns a read-only list of cart items.
  List<CartItemModel> get items => List.unmodifiable(_items.values);

  /// Returns the number of unique items in the cart.
  int get itemCount => _items.length;

  /// Calculates the total price of all items in the cart, including GST.
  double get grandTotal {
    double total = 0.0;
    _items.forEach((key, item) {
      final itemTotalPrice = item.finalUnitPrice * item.quantity;
      final gstAmount = itemTotalPrice * (item.gstPercentage / 100);
      total += itemTotalPrice + gstAmount;
    });
    return total;
  }

  // --- Cart Modification Methods ---

  /// Adds an item to the cart or updates its quantity if it already exists.
  void addItem(CartItemModel newItem) {
    final existingItem = _items[newItem.id];

    if (existingItem != null) {
      // Item exists, update quantity (and potentially price if logic requires)
      // For now, we assume the passed newItem has the correct price for the *total* new quantity
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + newItem.quantity,
        // If price changes based on total quantity, update basic/finalUnitPrice here
        // based on the combined quantity and price slabs.
        // This requires access to the price calculation logic.
        // Example:
        // basicUnitPrice: _calculatePriceForQuantity(existingItem.quantity + newItem.quantity, priceSlabs),
        // finalUnitPrice: _calculatePriceForQuantity(existingItem.quantity + newItem.quantity, priceSlabs),
        basicUnitPrice: newItem.basicUnitPrice, // Assuming newItem has price for the *added* quantity's slab
        finalUnitPrice: newItem.finalUnitPrice, // Adjust if needed
      );
      _items[newItem.id] = updatedItem;
    } else {
      // Item doesn't exist, add it
      _items[newItem.id] = newItem;
    }
    notifyListeners(); // Notify UI about the change
  }

  /// Removes an item completely from the cart.
  void removeItem(String itemId) {
    if (_items.containsKey(itemId)) {
      _items.remove(itemId);
      notifyListeners();
    }
  }

  /// Updates the quantity of a specific item in the cart.
  /// Requires recalculating price if it depends on quantity tiers.
  void updateQuantity(String itemId, int newQuantity) {
    final item = _items[itemId];
    if (item != null && newQuantity > 0) {
      // TODO: Recalculate basicUnitPrice and finalUnitPrice based on newQuantity and price slabs
      // This requires access to the original product's price slabs or a pricing service.
      // For now, we'll keep the existing unit price, which might be inaccurate if quantity changes tiers.
      // double newBasicUnitPrice = _calculatePriceForQuantity(newQuantity, item.priceSlabs); // Hypothetical
      // double newFinalUnitPrice = newBasicUnitPrice; // Adjust if needed

      _items[itemId] = item.copyWith(
        quantity: newQuantity,
        // basicUnitPrice: newBasicUnitPrice,
        // finalUnitPrice: newFinalUnitPrice,
      );
      notifyListeners();
    } else if (item != null && newQuantity <= 0) {
      // Remove item if quantity becomes zero or less
      removeItem(itemId);
    }
  }

  /// Clears all items from the cart.
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // --- Helper for Price Calculation (Example - Needs Price Slab Data) ---
  // double _calculatePriceForQuantity(int quantity, List<Map<String, dynamic>> priceSlabs) {
  //   // Implement the price slab logic here, similar to _calculatePricePerUnit
  //   // This function needs access to the specific product's price slabs.
  //   // You might need to store slabs in CartItemModel or fetch them.
  //   double pricePerUnit = priceSlabs.firstWhereOrNull((s) => s['quantity'] == 1)?['price'] ?? 0.0; // Default/initial price
  //   priceSlabs.sort((a, b) => (a['quantity'] as int).compareTo(b['quantity'] as int));
  //   for (var slab in priceSlabs.reversed) {
  //       if (quantity >= (slab['quantity'] as int)) {
  //           pricePerUnit = slab['price'] as double;
  //           break;
  //       }
  //   }
  //    if (priceSlabs.isNotEmpty && quantity < (priceSlabs.first['quantity'] as int)) {
  //        pricePerUnit = priceSlabs.first['price'] as double;
  //   }
  //   return pricePerUnit;
  // }
}