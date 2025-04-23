import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:Semikart/managers/auth_manager.dart'; // Import AuthManager provider
import 'red_button.dart'; // Import your custom RedButton
import 'popup.dart'; // Import your CustomPopup widget
// Removed LoginPassword import as AuthWrapper handles navigation
// import '../login_signup/login_password.dart';
import '../login_signup/login_password.dart'; // Import the screen
import '../profile/profile_screen.dart';
import '../../base_scaffold.dart';
import '../home/order_history.dart';
import '../../providers/profile_image_provider.dart';
import '../../providers/user_profile_provider.dart'; // NEW: import user profile data
// Import AuthManager provider

class HamburgerMenu extends ConsumerWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final user = ref.watch(userProfileProvider); // NEW: get name + email

    return Drawer(
      width: screenWidth * 0.75,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage)
                        : const AssetImage('public/assets/images/profile_picture.png')
                            as ImageProvider,
                  ),
                  SizedBox(height: verticalSpacingMedium),

                  // ✅ Dynamic Full Name
                  Text(
                    user.fullName.isNotEmpty ? user.fullName : 'Username',
                    style: TextStyle(fontSize: nameFontSize, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: verticalSpacingSmall),

                  // ✅ Dynamic Email
                  Text(
                    user.email.isNotEmpty ? user.email : 'username@gmail.com',
                    style: TextStyle(fontSize: emailFontSize, color: Colors.grey),
                  ),

                  SizedBox(height: verticalSpacingLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RedButton(
                        label: 'Edit Profile',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            _createFadeRoute(const BaseScaffold(), initialIndex: 4),
                          );
                        },
                        width: buttonWidth,
                        height: buttonHeight,
                        fontSize: buttonFontSize,
                      ),
                      const SizedBox(width: 16),
                      RedButton(
  label: 'Logout',
  onPressed: () async {
  Navigator.pop(context);
  final confirmed = await CustomPopup.show(
    context: context,
    title: 'Logout',
    message: 'Are you sure you want to logout?',
    buttonText: 'Confirm',
    cancelButtonText: 'Cancel',
    imagePath: 'public/assets/images/Alert.png',
  );

  if (confirmed == true) {
  await ref.read(authManagerProvider.notifier).logout();

  // Fallback navigation to root (triggers AuthWrapper logic)
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
}

},

  width: screenWidth * 0.3,
  height: 40,
  isWhiteButton: true,
),

<<<<<<< HEAD
=======
                          // --- Check if confirmed (popup returns true) ---
                          if (confirmed == true) {
                            // Call the logout method from AuthManager
                            // AuthWrapper will handle navigation based on state change
                            await ref.read(authManagerProvider.notifier).logout();
                          }
                          // --- Removed explicit navigation ---
                          // .then((_) {
                          //   Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                          //     (route) => false,
                          //   );
                          // });
                        },
                        width: buttonWidth,
                        height: buttonHeight,
                        fontSize: buttonFontSize,
                      ),
>>>>>>> 110dcc2f7cbb89114f0ded3c8ef2bc0c26862c15
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: verticalSpacingXLarge),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
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
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderHistory()),
                      );
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
