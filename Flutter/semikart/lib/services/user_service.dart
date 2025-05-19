import 'dart:async';
import 'dart:convert';
import 'dart:developer'; // For logging
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../managers/auth_manager.dart'; // Import ApiUser from AuthManager

// User Profile model to replace Firestore DocumentSnapshot
class UserProfile {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? phoneNumber;
  final String? profileImageUrl;
  final bool sendOrderEmails;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  UserProfile({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.companyName,
    this.phoneNumber,
    this.profileImageUrl,
    this.sendOrderEmails = true,
    this.createdAt,
    this.updatedAt,
  });
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? json['first_name'],
      lastName: json['lastName'] ?? json['last_name'],
      companyName: json['companyName'] ?? json['company_name'],
      phoneNumber: json['phoneNumber'] ?? json['phone_number'] ?? json['phone'],
      profileImageUrl: json['profileImageUrl'] ?? json['profile_image_url'] ?? json['photoURL'],
      sendOrderEmails: json['sendOrderEmails'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'sendOrderEmails': sendOrderEmails,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
  
  // Helper for full name
  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    } else {
      return '';
    }
  }
}

class UserService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://172.16.1.154:8080/semikartapi'; // Match your auth_manager.dart baseUrl
  
  // --- Create or Update User Profile ---
  Future<bool> upsertUserProfile({
    required ApiUser user,
    String? firstName,
    String? lastName, 
    String? companyName,
    String? phoneNumber,
    bool sendOrderEmails = true,
  }) async {
    try {
      // Prepare data for API
      final data = {
        'email': user.email,
        'sendOrderEmails': sendOrderEmails,
        'profileImageUrl': user.photoURL,
      };
      
      // Add optional fields if provided
      if (firstName != null && firstName.isNotEmpty) data['firstName'] = firstName;
      if (lastName != null && lastName.isNotEmpty) data['lastName'] = lastName;
      if (companyName != null && companyName.isNotEmpty) data['companyName'] = companyName;
      if (phoneNumber != null && phoneNumber.isNotEmpty) data['phoneNumber'] = phoneNumber;
      
      // Handle display name from API User if first/last name are missing
      if (data['firstName'] == null && data['lastName'] == null && 
          user.displayName != null && user.displayName!.isNotEmpty) {
        List<String> nameParts = user.displayName!.split(' ');
        if (nameParts.isNotEmpty) {
          data['firstName'] = nameParts.first;
          if (nameParts.length > 1) {
            data['lastName'] = nameParts.sublist(1).join(' ');
          }
        } else {
          data['firstName'] = user.displayName;
        }
      }
      
      // Make API call
      final response = await _dio.post(
        '$baseUrl/users/${user.id}',
        data: FormData.fromMap(data),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("User profile created/updated for ${user.id}");
        return true;
      } else {
        log("Error updating user profile: ${response.statusCode} ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      log("Error creating/updating user profile: $e");
      return false;
    }
  }

  // --- Get User Profile (as Future) ---
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response = await _dio.get('$baseUrl/users/$userId');
      
      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data);
      } else {
        log("User profile not found for ID: $userId");
        return null;
      }
    } catch (e) {
      log("Error fetching user profile for ID $userId: $e");
      return null;
    }
  }

  // --- Get User Profile (as Stream) ---
  // Note: APIs don't provide streams, so we simulate one with periodic polling
  Stream<UserProfile?> getUserProfileStream(String userId) {
    // Create a StreamController to manage the stream
    final controller = StreamController<UserProfile?>();
    
    // Initial fetch
    getUserProfile(userId).then((profile) {
      if (!controller.isClosed) {
        controller.add(profile);
      }
    });
    
    // Set up periodic polling (every 30 seconds)
    final timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!controller.isClosed) {
        getUserProfile(userId).then((profile) {
          if (!controller.isClosed) {
            controller.add(profile);
          }
        });
      }
    });
    
    // Clean up when the stream is no longer needed
    controller.onCancel = () {
      timer.cancel();
      controller.close();
    };
    
    return controller.stream;
  }

  // --- Update Specific User Profile Fields ---
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      // Add a timestamp for the last update
      data['updatedAt'] = DateTime.now().toIso8601String();
      
      final response = await _dio.patch(
        '$baseUrl/users/$userId',
        data: FormData.fromMap(data),
      );
      
      if (response.statusCode == 200) {
        log("User profile updated for ID: $userId");
        return true;
      } else {
        log("Error updating user profile: ${response.statusCode} ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      log("Error updating user profile for ID $userId: $e");
      return false;
    }
  }

  // --- Check if User Profile Exists ---
  Future<bool> doesUserProfileExist(String userId) async {
    try {
      final response = await _dio.head('$baseUrl/users/$userId');
      return response.statusCode == 200;
    } catch (e) {
      log("Error checking user profile existence for ID $userId: $e");
      return false; // Assume not exists on error
    }
  }
}

// --- Riverpod Provider for UserService ---
final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

// --- StreamProvider for the current user's profile ---
final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final authState = ref.watch(authManagerProvider);
  final userService = ref.watch(userServiceProvider);

  final userId = authState.user?.id;

  if (userId != null) {
    return userService.getUserProfileStream(userId);
  } else {
    return Stream.value(null);
  }
});

// For compatibility with existing code expecting a DocumentSnapshot
// This will help transition from Firestore
class DocumentData {
  final Map<String, dynamic> _data;
  final String id;
  
  DocumentData(this.id, this._data);
  
  Map<String, dynamic> data() => _data;
  bool get exists => _data.isNotEmpty;
  
  dynamic get(String field) => _data[field];
  
  // For direct property access
  dynamic operator [](String key) => _data[key];
}

// Create a compatibility provider that returns a DocumentData-like object
final userDocumentProvider = StreamProvider<DocumentData?>((ref) {
  final authState = ref.watch(authManagerProvider);
  final userService = ref.watch(userServiceProvider);

  final userId = authState.user?.id;

  if (userId != null) {
    return userService.getUserProfileStream(userId).map((profile) {
      if (profile == null) return null;
      return DocumentData(profile.id, profile.toJson());
    });
  } else {
    return Stream.value(null);
  }
});
