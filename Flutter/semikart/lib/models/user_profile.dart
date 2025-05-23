// UserProfile model for API response from /getuserinfo
class UserProfile {
  final String firstName;
  final String lastName;
  final String companyName;
  final int customerId;
  final String mobileNo;
  final String userType;
  final String email;
  final String? profileImageUrl;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.customerId,
    required this.mobileNo,
    required this.userType,
    required this.email,
    this.profileImageUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      companyName: json['companyName'] ?? '',
      customerId: json['customerId'] ?? 0,
      mobileNo: json['mobileNo'] ?? '',
      userType: json['userType'] ?? '',
      email: json['email'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
