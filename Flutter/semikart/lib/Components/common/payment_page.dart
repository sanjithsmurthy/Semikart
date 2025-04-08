import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'edit_textbox.dart';
import 'edit_textbox2.dart';
import 'items_dropdown.dart';
import 'red_button.dart';


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

              // My Items Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 16.0),
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
                      'My Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ItemDropdownCard(
                      mfrPartNumber: 'X22223201',
                      manufacturer: 'E-T-A',
                      basicUnitPrice: 2581.32,
                      quantity: 5,
                      finalUnitPrice: 2581.32,
                    ),
                    const SizedBox(height: 12),
                    ItemDropdownCard(
                      mfrPartNumber: 'X22223201',
                      manufacturer: 'E-T-A',
                      basicUnitPrice: 2581.32,
                      quantity: 5,
                      finalUnitPrice: 2581.32,
                    ),
                  ],
                ),
              ),

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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.radio_button_checked, color: Color(0xFFA51414)),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 20),
              RedButton(
                label: 'Continue to payment',
                onPressed: () {
                  // Add payment navigation logic here
                },
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
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
