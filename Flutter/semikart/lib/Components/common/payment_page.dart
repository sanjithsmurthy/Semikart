import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bottom_bar.dart';
import 'edit_textbox.dart';
import 'edit_textbox2.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: 66.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            iconSize: 35.0,
            onPressed: () {},
          ),
          const SizedBox(width: 15.0),
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                  );
                },
                child: Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  height: 20.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset('public/assets/images/whatsapp_icon.png'),
                iconSize: 20.0,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.black),
                iconSize: 27.0,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66.0);
}

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: CombinedAppBar(
          title: "Payment",
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const EditTextBox(),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
                title: const Text(
                  "Billing Address same as shipping address",
                  style: TextStyle(fontSize: 16),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color(0xFFA51414),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              const EditTextBox2(),
              const SizedBox(height: 16),

              // Razorpay Container
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Default Payment Option",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.radio_button_checked,
                            color: Color(0xFFA51414)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Razorpay gateway supports the following payment modes: All Credit Cards, All Debit Cards, NetBanking, Wallet, UPI/QR, EMI, Paylater",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Terms & Conditions Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "1. We hereby declare that, the parts procured from Aqtronics/SemiKart against our PO number is not sold to any of the restricted entity by US or UK and also not used in any of the products/applications such as weapon of mass destruction/aerospace or defence systems restricted by US & UK. Furthermore these parts are not to be sold to any such entities within India. In doing so, we are aware a flag will be raised to the respective supplier and all business proceedings will be cancelled.",
                              style: TextStyle(fontSize: 14, height: 1.6),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "2. Order delivery timelines may differ when procured from multiple suppliers.",
                              style: TextStyle(fontSize: 14, height: 1.6),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "3. Standard lead time will be 2-3 weeks for stock parts after receiving of PO.",
                              style: TextStyle(fontSize: 14, height: 1.6),
                            ),
                          ],
                        );
                      },
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
}

class CombinedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CombinedAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Header(),
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                'public/assets/images/back.svg',
                color: const Color(0xFFA51414),
              ),
              iconSize: 24.0,
              onPressed: onBackPressed,
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
