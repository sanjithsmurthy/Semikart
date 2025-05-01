import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer'; // For logging
import '../managers/auth_manager.dart'; // Import AuthManager to get UID

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionPath = 'users'; // Define collection name

  // --- Create or Update User Profile ---
  // Creates a new document if it doesn't exist, or merges data if it does.
  // Useful for both initial sign-up and Google Sign-In where profile might exist.
  Future<void> upsertUserProfile({
    required User user,
    String? firstName, // Make fields optional for Google Sign-In
    String? lastName,
    String? companyName,
    String? phoneNumber,
    // Add other fields from your SignUpScreen/ProfileScreen as needed
    // e.g., String? gstin, String? userType, etc.
    bool sendOrderEmails = true, // Default values
    // Removed sendOrderSMS parameter
  }) async {
    final docRef = _db.collection(_collectionPath).doc(user.uid);

    // Prepare data, only include non-null values provided during sign-up
    // Email is always taken from the auth user object
    final data = <String, dynamic>{
      'email': user.email, // Essential link
      'createdAt': FieldValue.serverTimestamp(), // Record creation time
      'lastLoginAt': FieldValue.serverTimestamp(), // Update on every upsert
      'sendOrderEmails': sendOrderEmails,
      // Removed 'sendOrderSMS' field
      'profileImageUrl': user.photoURL, // Add this line
    };

    // Add optional fields if they are provided (not null)
    if (firstName != null && firstName.isNotEmpty) data['firstName'] = firstName;
    if (lastName != null && lastName.isNotEmpty) data['lastName'] = lastName;
    if (companyName != null && companyName.isNotEmpty) data['companyName'] = companyName;
    if (phoneNumber != null && phoneNumber.isNotEmpty) data['phoneNumber'] = phoneNumber;

    // Handle display name from Google Sign-In if first/last name are missing
    if (data['firstName'] == null && data['lastName'] == null && user.displayName != null && user.displayName!.isNotEmpty) {
       // Attempt to split display name into first and last
       List<String> nameParts = user.displayName!.split(' ');
       if (nameParts.isNotEmpty) {
         data['firstName'] = nameParts.first;
         if (nameParts.length > 1) {
           data['lastName'] = nameParts.sublist(1).join(' ');
         }
       } else {
         data['firstName'] = user.displayName; // Use full display name if split fails
       }
    }


    try {
      // Use set with merge: true to create or update
      await docRef.set(data, SetOptions(merge: true));
      log("User profile created/updated in Firestore for ${user.uid}. Image URL: ${user.photoURL}"); // Log URL
    } catch (e) {
      log("Error creating/updating user profile in Firestore for ${user.uid}: $e");
      // Consider how to handle this error (e.g., logging, user notification)
      rethrow; // Rethrow to potentially be caught by the calling UI
    }
  }

  // --- Get User Profile (as Future) ---
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(String uid) async {
    try {
      final docSnapshot = await _db.collection(_collectionPath).doc(uid).get();
      if (!docSnapshot.exists) {
        log("User profile not found in Firestore for UID: $uid");
        // Decide how to handle this - maybe create a default profile?
        // For now, just return the non-existent snapshot.
      }
      return docSnapshot;
    } catch (e) {
      log("Error fetching user profile for UID $uid: $e");
      rethrow;
    }
  }

  // --- Get User Profile (as Stream) ---
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserProfileStream(String uid) {
    return _db.collection(_collectionPath).doc(uid).snapshots();
  }

  // --- Update Specific User Profile Fields ---
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
     final docRef = _db.collection(_collectionPath).doc(uid);
     try {
       // Add a timestamp for the last update
       data['updatedAt'] = FieldValue.serverTimestamp();
       // Remove sendOrderSMS if it exists in the map before updating
       data.remove('sendOrderSMS');
       await docRef.update(data);
       log("User profile updated for UID: $uid");
     } catch (e) {
       log("Error updating user profile for UID $uid: $e");
       rethrow;
     }
  }

  // --- Check if User Profile Exists ---
  Future<bool> doesUserProfileExist(String uid) async {
    try {
      final doc = await _db.collection(_collectionPath).doc(uid).get();
      return doc.exists;
    } catch (e) {
      log("Error checking user profile existence for UID $uid: $e");
      return false; // Assume not exists on error
    }
  }
}

// --- Riverpod Provider for UserService ---
final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

// --- StreamProvider for the current user's document ---
// Make the return type nullable
final userDocumentProvider = StreamProvider<DocumentSnapshot<Map<String, dynamic>>?>((ref) {
  final authState = ref.watch(authManagerProvider); // Watch auth state
  final userService = ref.watch(userServiceProvider); // Watch user service

  final uid = authState.user?.uid; // Get current user's UID

  if (uid != null) {
    // If logged in, return the stream from UserService
    return userService.getUserProfileStream(uid);
  } else {
    // If not logged in, return a stream that emits null
    return Stream.value(null);
  }
});
