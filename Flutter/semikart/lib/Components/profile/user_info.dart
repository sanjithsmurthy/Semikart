import 'package:flutter/material.dart';
import '../common/custom_text_field.dart'; // Import custom text fields
import '../common/two_radios.dart'; // Import radio buttons

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Define controllers for text fields
    final firstNameController = TextEditingController(text: "User");
    final lastNameController = TextEditingController(text: "Name");
    final companyNameController = TextEditingController(text: "Semikart");
    final emailController = TextEditingController(text: "username@gmail.com");
    final phoneNumberController = TextEditingController(text: "7868475968");
    final alternateNumberController = TextEditingController(text: "8647587959");
    final gstinController = TextEditingController(text: "6hjgs6n9u");
    final typeController = TextEditingController(text: "7868475968");
    final sourceController = TextEditingController(text: "8647587959");

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // Responsive width
            padding: const EdgeInsets.all(
                16.0), // Padding inside the white background
            decoration: BoxDecoration(
              color: Colors.white, // White background color
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and edit icon inside the shadow box
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "User Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.red),
                      onPressed: () {
                        // Handle edit action
                        print("Edit button pressed");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Box with shadow
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.85, // Responsive width
                  padding: const EdgeInsets.all(16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    color: Colors.white, // Box background color
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Name
                      SizedBox(
                        width: 334, // Updated width
                        child: CustomTextField(
                          label: "First Name",
                          controller: firstNameController,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Last Name
                      SizedBox(
                        width: 334, // Updated width
                        child: CustomTextField(
                          label: "Last Name",
                          controller: lastNameController,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Company Name
                      SizedBox(
                        width: 334, // Updated width
                        child: CustomTextField(
                          label: "Company Name",
                          controller: companyNameController,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Email
                      SizedBox(
                        width: 334, // Updated width
                        child: CustomTextField(
                          label: "Your Email",
                          controller: emailController,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Phone Number and Alternate Number
                      Row(
                        children: [
                          SizedBox(
                            width: 155, // Updated width
                            child: CustomTextField(
                              label: "Phone Number",
                              controller: phoneNumberController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 155, // Updated width
                            child: CustomTextField(
                              label: "Alternate No.",
                              controller: alternateNumberController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // GSTIN Number
                      SizedBox(
                        width: 334, // Updated width
                        child: CustomTextField(
                          label: "GSTIN NO.",
                          controller: gstinController,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Type and Source
                      Row(
                        children: [
                          SizedBox(
                            width: 155, // Updated width
                            child: CustomTextField(
                              label: "Type",
                              controller: typeController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 155, // Updated width
                            child: CustomTextField(
                              label: "Source",
                              controller: sourceController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Radio Buttons for Email Updates
                      Row(
                        children: [
                          const Text(
                            "Send Order Updates Emails",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA51414), // Updated color
                            ),
                          ),
                          const Spacer(),
                          TwoRadioButtons(
                            options: ['Yes', 'No'], // Updated options
                            initialSelection:
                                0, // Default selection (0 for the first button)
                            onSelectionChanged: (int selectedValue) {
                              print('Selected value (email): $selectedValue');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Radio Buttons for SMS Updates
                      Row(
                        children: [
                          const Text(
                            "Send Order Updates SMS",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA51414), // Updated color
                            ),
                          ),
                          const Spacer(),
                          TwoRadioButtons(
                            options: ['Yes', 'No'], // Updated options
                            initialSelection:
                                0, // Default selection (0 for the first button)
                            onSelectionChanged: (int selectedValue) {
                              print('Selected value (sms): $selectedValue');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
