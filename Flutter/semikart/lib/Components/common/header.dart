import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String? title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onLogoTap;

  const Header({
    super.key,
    this.showBackButton = false,
    this.title,
    this.onBackPressed,
    this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04, // 4% of screen width
                  top: screenHeight * 0.04, // 4% of screen height
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFA51414),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: screenWidth * 0.02), // 2% of screen width
                    Image.asset(
                      'public/assets/images/semikart_logo_medium.png',
                      width: screenWidth * 0.3, // 30% of screen width
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // 2% of screen height
              Expanded(
                child: ListView(
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.shopping_bag,
                      text: 'Products',
                      onTap: () {
                        Navigator.pushNamed(context, '/products');
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height
                    _buildMenuItem(
                      context,
                      icon: Icons.history,
                      text: 'Order History',
                      onTap: () {
                        Navigator.pushNamed(context, '/orderHistory');
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height
                    _buildMenuItem(
                      context,
                      icon: Icons.list_alt,
                      text: 'BOM History',
                      onTap: () {
                        Navigator.pushNamed(context, '/bomHistory');
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height
                    _buildMenuItem(
                      context,
                      icon: Icons.contact_support,
                      text: 'Contact Us',
                      onTap: () {
                        Navigator.pushNamed(context, '/contactUs');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: preferredSize.height,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, // 2% of screen width
            vertical: screenHeight * 0.01, // 1% of screen height
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    iconSize: screenWidth * 0.08, // 8% of screen width
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  SizedBox(width: screenWidth * 0.04), // 4% of screen width
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: onLogoTap,
                        child: Image.asset(
                          'public/assets/images/semikart_logo_medium.png',
                          height: screenHeight * 0.026, // 25% of screen height
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.whatsapp),
                        iconSize: screenWidth * 0.077, // 5% of screen width
                        onPressed: () async {
                          final Uri whatsappUrl = Uri.parse('https://wa.me/919113999367');
                          if (await canLaunchUrl(whatsappUrl)) {
                            await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
                          } else {
                            // Could not launch WhatsApp
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Could not open WhatsApp')),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.black),
                        iconSize: screenWidth * 0.07, // 6% of screen width
                        onPressed: () async {
                          final Uri phoneUrl = Uri.parse('tel:+919113999367');
                          if (await canLaunchUrl(phoneUrl)) {
                            await launchUrl(phoneUrl);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Could not open phone dialer')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              if (showBackButton)
                Container(
                  height: screenHeight * 0.07, // 7% of screen height
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02), // Move the back icon 0.5% of screen width to the right
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'public/assets/images/back.svg',
                            color: const Color(0xFFA51414),
                          ),
                          iconSize: screenWidth * 0.06, // 6% of screen width
                          onPressed: onBackPressed,

                        ),
                      ),
                      SizedBox(width: screenWidth * 0.025), // Add spacing to move the title to the right
                      Text(
                        title ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.045, // 4.5% of screen width
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFFA51414),
        size: screenWidth * 0.06, // 6% of screen width
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth * 0.04, // 4% of screen width
          color: Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: const Color(0xFFA51414),
        size: screenWidth * 0.04, // 4% of screen width
      ),
      onTap: onTap,
    );
  }

  @override
  Size get preferredSize => showBackButton
      ? const Size.fromHeight(126.0)
      : const Size.fromHeight(66.0);
}