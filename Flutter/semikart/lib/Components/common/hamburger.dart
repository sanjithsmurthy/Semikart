import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'dart:io'; // For FileImage
import '../../managers/auth_manager.dart'; // Import AuthManager provider
import '../../services/user_service.dart'; // Import userDocumentProvider
import 'red_button.dart'; // Import your custom RedButton
import '../../base_scaffold.dart';
import '../../providers/profile_image_provider.dart';
import '../../app_navigator.dart'; // Import AppNavigator for navigation
import 'popup.dart'; // Import CustomPopup

class HamburgerMenu extends ConsumerStatefulWidget {
  const HamburgerMenu({super.key});

  @override
  ConsumerState<HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends ConsumerState<HamburgerMenu> {
  double _avatarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger fade-in after build
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _avatarOpacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Reference screen dimensions
    const double refWidth = 412.0;
    const double refHeight = 917.0;

    // Calculate scaling factors
    final double widthScale = screenWidth / refWidth;
    final double heightScale = screenHeight / refHeight;
    // Use widthScale for font sizes and icon sizes for consistency
    final double scale = widthScale;

    // Scaled dimensions
    final double leftPadding = 25.0 * widthScale;
    final double topPadding = 40.0 * heightScale;
    final double iconSize = 25.0 * scale;
    final double logoHeight = 23.0 * heightScale;
    final double horizontalSpacing = 8.0 * widthScale;
    final double verticalSpacingSmall = 4.0 * heightScale;
    final double verticalSpacingMedium = 8.0 * heightScale;
    final double verticalSpacingLarge = 16.0 * heightScale;
    final double verticalSpacingXLarge = 36.0 * heightScale;
    final double avatarRadius = 50.0 * scale;
    final double nameFontSize = 16.0 * scale;
    final double emailFontSize = 14.0 * scale;
    final double buttonWidth = 120.0 * widthScale;
    final double buttonHeight = 40.0 * heightScale;
    final double buttonFontSize = 14.0 * scale;

    final profileImage = ref.watch(profileImageProvider);
    // Watch the user document stream provider (now nullable)
    final userDocAsyncValue = ref.watch(userDocumentProvider);

    return Drawer(
      width: screenWidth * 0.75,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... Top bar ...
            Padding(
              padding: EdgeInsets.only(
                left: leftPadding,
                top: topPadding,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)),
                    iconSize: iconSize,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: horizontalSpacing),
                  Image.asset(
                    'public/assets/images/semikart_logo_medium.png',
                    height: logoHeight,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            SizedBox(height: verticalSpacingXLarge),

            // Use AsyncValue.when to handle loading/error/data states
            userDocAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFA51414))),
              error: (err, stack) => Center(child: Text('Error: $err')),
              // userDoc can now be null
              data: (userDoc) {
                String firstName = '';
                String lastName = '';
                String email = 'Not Logged In';
                String fullName = '';
                String? profileImageUrl; // Variable to hold the URL

                // Check if userDoc is not null and exists before accessing data
                if (userDoc != null && userDoc.exists) {
                  final userData = userDoc.data();
                  firstName = userData?['firstName'] as String? ?? '';
                  lastName = userData?['lastName'] as String? ?? '';
                  email = userData?['email'] as String? ?? 'No Email';
                  // Read the profile image URL from Firestore data
                  profileImageUrl = userData?['profileImageUrl'] as String?; // Uncomment and use this
                }
                fullName = '${firstName.trim()} ${lastName.trim()}'.trim();

                // Determine background image for CircleAvatar
                ImageProvider backgroundImage;
                if (profileImage != null) {
                  // 1. Priority: Locally selected image
                  backgroundImage = FileImage(profileImage);
                } else if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
                  // 2. Priority: URL from Firestore
                  backgroundImage = NetworkImage(profileImageUrl);
                } else {
                  // 3. Fallback: Default asset
                  backgroundImage = const AssetImage('public/assets/images/profile_picture.png');
                }

                return Center(
                  child: Column(
                    children: [
                      AnimatedOpacity(
                        opacity: _avatarOpacity,
                        duration: const Duration(milliseconds: 600),
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: backgroundImage, // Use the determined image provider
                          onBackgroundImageError: (exception, stackTrace) {
                            // Optional: Handle image loading errors
                            print("Error loading profile image in hamburger: $exception");
                          },
                        ),
                      ),
                      SizedBox(height: verticalSpacingMedium),
                      Text(
                        fullName.isNotEmpty ? fullName : 'Guest', // Display name or 'Guest'
                        style: TextStyle(fontSize: nameFontSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: verticalSpacingSmall),
                      Text(
                        email, // Display email or 'Not Logged In'
                        style: TextStyle(fontSize: emailFontSize, color: Colors.grey),
                      ),
                      SizedBox(height: verticalSpacingLarge),
                      // Only show Edit Profile button if logged in (userDoc is not null)
                      if (userDoc != null && userDoc.exists)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RedButton(
                              label: 'Edit Profile',
                              onPressed: () {
                                Navigator.pop(context); // Close drawer
                                Navigator.pushReplacement(
                                  context,
                                  _createFadeRoute(const BaseScaffold(), initialIndex: 4),
                                );
                              },
                              width: buttonWidth,
                              height: buttonHeight,
                              fontSize: buttonFontSize,
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: verticalSpacingXLarge),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // ... existing _buildMenuItem calls ...
                  _buildMenuItem(
                    context,
                    icon: Icons.shopping_bag,
                    text: 'Products',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        _createFadeRoute(const BaseScaffold(), initialIndex: 1),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    icon: Icons.history,
                    text: 'Order History',
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      AppNavigator.toProfile(); // Switch to the Profile tab
                      AppNavigator.pushOrderHistory(); // Push the Order History page within the Profile tab
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    icon: Icons.contact_support,
                    text: 'Contact Us',
                    onTap: () {
                      Navigator.pop(context);
                      print("Navigate to Contact Us");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createFadeRoute(Widget page, {int? initialIndex}) {
    final Widget targetPage = (page is BaseScaffold && initialIndex != null)
        ? BaseScaffold(key: ValueKey('BaseScaffold_$initialIndex'), initialIndex: initialIndex)
        : page;

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFA51414), size: 24),
        title: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFA51414), size: 24),
        onTap: onTap,
        hoverColor: Colors.grey.shade100,
        splashColor: Colors.red.shade100,
      ),
    );
  }
}
