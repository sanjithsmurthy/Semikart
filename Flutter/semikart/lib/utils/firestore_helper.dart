// firestore_helper.dart - Add this file to your lib/utils directory
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Add a single L2 category
  static Future<void> addL2Category({
    required String l1Id,
    required String name,
  }) async {
    try {
      await _firestore.collection('l2_products').add({
        'name': name,
        'l1id': l1Id,
      });
      print('Added L2 category: $name for L1: $l1Id');
    } catch (e) {
      print('Error adding L2 category: $e');
      rethrow;
    }
  }
  
  // Add multiple L2 categories for an L1 category
  static Future<void> addMultipleL2Categories({
    required String l1Id,
    required List<String> names,
  }) async {
    try {
      final batch = _firestore.batch();
      
      for (final name in names) {
        final docRef = _firestore.collection('l2_products').doc();
        batch.set(docRef, {
          'name': name,
          'l1id': l1Id,
        });
      }
      
      await batch.commit();
      print('Added ${names.length} L2 categories for L1: $l1Id');
    } catch (e) {
      print('Error adding multiple L2 categories: $e');
      rethrow;
    }
  }
  
  // Simple method to add sample data for testing
  static Future<void> addSampleData() async {
    try {
      // Get all L1 categories
      final l1Snapshot = await _firestore.collection('l1_products').get();
      
      // For each L1 category, add some L2 categories
      for (final l1Doc in l1Snapshot.docs) {
        final l1Id = l1Doc.id;
        final l1Data = l1Doc.data();
        final l1Name = l1Data['name'] ?? 'Unknown';
        
        // Add 3 sample L2 categories
        await addMultipleL2Categories(
          l1Id: l1Id,
          names: [
            '$l1Name - Subcategory 1',
            '$l1Name - Subcategory 2',
            '$l1Name - Subcategory 3',
          ],
        );
      }
      
      print('Sample data added successfully!');
    } catch (e) {
      print('Error adding sample data: $e');
      rethrow;
    }
  }
}