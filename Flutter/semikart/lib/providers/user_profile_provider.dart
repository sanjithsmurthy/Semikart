import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final String email;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String get fullName => '$firstName $lastName';
}

final userProfileProvider = StateProvider<UserProfile>((ref) {
  return const UserProfile(firstName: '', lastName: '', email: '');
});
