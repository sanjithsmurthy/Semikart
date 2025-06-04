import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Semikart/managers/auth_manager.dart'; // Use the new AuthManager
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart'; // Keep PasswordTextField import
import '../common/red_button.dart';
import '../common/inactive_red_button.dart';
import 'login_password.dart';
import '../common/forgot_password.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
// Removed ConfirmPasswordScreen import

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // --- Integrated State from ConfirmPasswordScreen ---
  // bool passwordsMatch = false; // Removed, replaced by _isPasswordMatching()
  bool isTermsAccepted = false;
  bool _areAllFieldsFilled = false;
  bool _isLoading = false; // Local loading state for button feedback

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final companyNameController = TextEditingController();
  final _passwordController = TextEditingController(); // Keep
  final _confirmPasswordController = TextEditingController(); // Keep

  // Password validation flags (from ConfirmPasswordScreen)
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  // --- End Integrated State ---


  @override
  void initState() {
    super.initState();
    // Add listeners to check field status and password validation
    firstNameController.addListener(_checkAllFieldsFilled);
    lastNameController.addListener(_checkAllFieldsFilled);
    emailController.addListener(_checkAllFieldsFilled);
    mobileNumberController.addListener(_checkAllFieldsFilled);
    companyNameController.addListener(_checkAllFieldsFilled);
    _passwordController.addListener(() { // Add password validation listener here
      _validatePassword(_passwordController.text);
      _checkAllFieldsFilled();
    });
    _confirmPasswordController.addListener(() { // Update UI on confirm password change
      setState(() {});
      _checkAllFieldsFilled(); // Also re-check overall fields
    });
  }

   @override
  void dispose() {
    // Remove listeners
    firstNameController.removeListener(_checkAllFieldsFilled);
    lastNameController.removeListener(_checkAllFieldsFilled);
    emailController.removeListener(_checkAllFieldsFilled);
    mobileNumberController.removeListener(_checkAllFieldsFilled);
    companyNameController.removeListener(_checkAllFieldsFilled);
    _passwordController.removeListener(() { _validatePassword(_passwordController.text); _checkAllFieldsFilled(); }); // Match listener removal
    _confirmPasswordController.removeListener(() { setState(() {}); _checkAllFieldsFilled(); }); // Match listener removal

    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    companyNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Removed _checkPasswordsAndFields - logic integrated into listeners/getters

  void _checkAllFieldsFilled() {
    // Check essential fields for Firebase email/password signup
    // Also check password requirements and match for button state
    setState(() {
      _areAllFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty && // Ensure password is not empty
          _confirmPasswordController.text.isNotEmpty; // Ensure confirm password is not empty
    });
  }

  // --- Integrated Methods from ConfirmPasswordScreen ---
  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8 && password.length <= 20;
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _checkAllFieldsFilled(); // Re-check overall fields when password changes
    });
  }

  bool _isPasswordMatching() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  bool _areAllRequirementsSatisfied() {
    return hasMinLength && hasUpperCase && hasNumber && hasSpecialChar;
  }

  Widget _buildRequirementItem(String text, bool isSatisfied, double fontSize, double iconSize, double spacing, double leftPadding) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: iconSize,
            color: isSatisfied ? Color.fromARGB(255, 25, 107, 27) : Color(0xFF989DA3),
          ),
          SizedBox(width: spacing * 2.5),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Color(0xFF989DA3),
            ),
          ),
        ],
      ),
    );
  }
  // --- End Integrated Methods ---


  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    if (!isSignUpButtonActive || _isLoading) return;

    setState(() { _isLoading = true; });

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = _passwordController.text.trim();
    final companyName = companyNameController.text.trim();
    final phoneNumber = mobileNumberController.text.trim(); // Assuming this holds the complete number

    final authManager = ref.read(authManagerProvider.notifier);
    // Call the updated signUp method with all the details
    await authManager.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      companyName: companyName,
      phoneNumber: phoneNumber,
    );

    if (!mounted) return;
    setState(() { _isLoading = false; });
  }

   Future<void> _googleSignIn() async {
     FocusScope.of(context).unfocus();
     if (_isLoading) return;

     setState(() { _isLoading = true; });
     final authManager = ref.read(authManagerProvider.notifier);
    //  await authManager.googleSignIn();

     if (!mounted) return;
     setState(() { _isLoading = false; });
  }

  // Determine if the sign-up button should be active using integrated logic
  bool get isSignUpButtonActive =>
      _areAllFieldsFilled &&
      _areAllRequirementsSatisfied() && // Check requirements
      _isPasswordMatching() && // Check match
      isTermsAccepted &&
      !_isLoading;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // --- Dynamic sizes from ConfirmPasswordScreen ---
    final double verticalSpacingSmall = screenHeight * 0.01;
    final double verticalSpacingMedium = screenHeight * 0.02;
    final double verticalSpacingLarge = screenHeight * 0.03;
    final double textFieldHeight = screenHeight * 0.06;
    final double headingFontSize = screenWidth * 0.04 * 0.75;
    final double requirementFontSize = screenWidth * 0.035 * 0.75;
    final double bulletIconSize = screenWidth * 0.03;
    final double checkIconSize = screenWidth * 0.05;
    final double alertIconSize = screenWidth * 0.04;
    final double alertFontSize = screenWidth * 0.03;
    final double leftPaddingValue = screenWidth * 0.075;
    // --- End Dynamic sizes ---

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... (Logo, Title, Google Sign In, OR Divider - unchanged) ...
                SizedBox(height: screenHeight * 0.08), // Space for the logo

                // Semikart Logo
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  width: screenWidth * 0.4, // 40% of screen width
                  height: screenHeight * 0.05, // 5% of screen height
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // "Create Your Account" Text
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055, // 6% of screen width
                    color: Colors.black, // Black text color
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Google Sign-In Button
                Center(
                  child: SignInWithGoogleButton(
                    onPressed: _googleSignIn,
                    isLoading: _isLoading,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Divider with "OR"
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        endIndent: screenWidth * 0.02, // Specify spacing
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Specify font size
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: screenWidth * 0.02, // Specify spacing
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing


                // CustomTextField for First Name
                Center(
                  child: CustomTextField(
                    controller: firstNameController,
                    label: "First Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Last Name
                Center(
                  child: CustomTextField(
                    controller: lastNameController,
                    label: "Last Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Email
                Center(
                  child: CustomTextField(
                    controller: emailController,
                    label: "Email",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final double responsiveBorderRadius = screenWidth * 0.028;

                      return TextSelectionTheme(
                        data: const TextSelectionThemeData(
                          selectionColor: Color(0xFFA51414),
                          selectionHandleColor: Color(0xFFA51414),
                        ),
                        child: IntlPhoneField(
                          cursorColor: const Color(0xFFA51414),
                          cursorWidth: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: const TextStyle(color: Color(0xFF757575), fontSize: 11),
                            floatingLabelStyle: const TextStyle(color: Color(0xFFA51414), fontSize: 12),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.0),
                              borderRadius: BorderRadius.circular(responsiveBorderRadius),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.0),
                              borderRadius: BorderRadius.circular(responsiveBorderRadius),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.0),
                              borderRadius: BorderRadius.circular(responsiveBorderRadius),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                            counterText: '',
                          ),
                          initialCountryCode: 'IN',
                          keyboardType: TextInputType.phone,
                          onChanged: (phone) {
                            mobileNumberController.text = phone.completeNumber;
                            _checkAllFieldsFilled();
                          },
                          onCountryChanged: (country) {
                            mobileNumberController.clear();
                            _checkAllFieldsFilled();
                          },
                          dropdownIcon: const Icon(Icons.arrow_drop_down, color: Color(0xFFA51414)),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.025), // Add spacing

                Center(
                  child: CustomTextField(
                    controller: companyNameController,
                    label: "Company Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.015), // Add spacing


                // --- Integrated Password Section ---
                // Password Field
                PasswordTextField(
                  controller: _passwordController,
                  label: "Password",
                  height: textFieldHeight,
                  onChanged: _validatePassword, // Use the integrated validator
                ),

                SizedBox(height: verticalSpacingLarge),

                // Password Requirements Heading and List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: leftPaddingValue),
                      child: Text(
                        "YOUR PASSWORD MUST CONTAIN",
                        style: TextStyle(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989DA3),
                        ),
                      ),
                    ),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("Between 8 and 20 characters", hasMinLength, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("1 upper case letter", hasUpperCase, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("1 or more numbers", hasNumber, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("1 or more special characters", hasSpecialChar, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                  ],
                ),

                SizedBox(height: verticalSpacingLarge),

                // Confirm Password Field (Using PasswordTextField)
                PasswordTextField( // Use PasswordTextField for consistency
                  controller: _confirmPasswordController,
                  height: textFieldHeight, // Assuming PasswordTextField accepts height
                  label: "Confirm Password",
                  // obscureText is handled internally by PasswordTextField
                  // suffixIcon is likely handled internally (visibility toggle), removing custom icon
                  // Keep onChanged to trigger UI updates and checks
                  onChanged: (value) {
                    // Update UI state, e.g., for the mismatch alert below and button state
                    setState(() {});
                    _checkAllFieldsFilled(); // Re-check button state
                  },
                ),

                // Alert Text for Password Mismatch (Keep this logic, it depends on the controllers)
                if (!_isPasswordMatching() && _confirmPasswordController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: verticalSpacingSmall, left: leftPaddingValue),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color(0xFFA51414),
                          size: alertIconSize,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Passwords do not match",
                          style: TextStyle(
                            fontSize: alertFontSize,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA51414),
                          ),
                        ),
                      ],
                    ),
                  ),
                // --- End Integrated Password Section ---

                SizedBox(height: screenHeight * 0.02), // Add spacing


                // ForgotPasswordButton for "Already have an account?"
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Already have an account?",
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPasswordNewScreen()),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Checkbox for Terms and Conditions
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value ?? false;
                          });
                          // No need to call _checkAllFieldsFilled here, getter handles it
                        },
                        activeColor: const Color(0xFFA51414),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () async {
                            // Show Terms & Conditions overlay dialog
                            final accepted = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                bool localAccepted = isTermsAccepted;
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white, // Ensure white background
                                      title: const Text('Terms & Conditions'),
                                      content: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.95, // Make overlay wider
                                        height: MediaQuery.of(context).size.height * 0.85, // Make overlay longer
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Terms & Conditions',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              const SizedBox(height: 12),
                                              const Text(
                                                '1. Acceptance And Cancellation Of Orders\n'
                                                'Acceptance of orders is subjected to written acknowledgement by Semikart. Any written acknowledgement of receipt of an order shall not, in and of itself, constitute such acceptance. Orders accepted by Semikart may be cancelled by customer only upon written consent of Semikart, provided the orders are not NCNR- Non cancellable Non returnable. Customer requests to reschedule shipments are subject to acceptance by Semikart in its sole discretion. Also orders cannot be cancelled or rescheduled after order has been submitted by Semikart to the shipment center. Right to allocate sales and limit quantities of selected products lies in Semikart’s reserve.\n\n'
                                                '2. Credit Policy\n'
                                                'Semi Kart is an Online portal operating on “ Pay and Purchase” model; Semikart does not entertain or extend credit to its customers Purchases and payments can be made as per the instructions on website.\n\n'
                                                '3. Returns\n'
                                                'Returns are not encouraged by Semikart. However under extraordinary circumstances returns maybe accepted, with Semikart’s written approval. This does not apply for Non cancellable and Non returnable orders.\n\n'
                                                '4. Prices\n'
                                                'All prices for Supplies provided by the Company are in INR and are exclusive of all central, state or local tax or other governmental charge or assessment relating to the production, sale or shipment of any Supplies, unless expressly provided otherwise, including but not limited to sales tax, including central and state sales tax and value added tax, octroi duty, service tax, education cess (and any other regulatory levy that may become applicable to the Company or to the Supplies from time to time) and other duties and taxes and any applicable transport and handling charges which will be added at the time of despatch and shall be payable by the Customer. Goods requested by Customer shall be charged at the price quoted in writing by the Company.\n\n'
                                                '5. Payments\n'
                                                'All payments will be made in INR only. Semikart offers payments through Visa and Mastercard and credit for qualified customers. Prepaid Wire Transfer/EFT/Proforma: Customers can wire the funds to our bank. After your order is placed we will e-mail a Proforma invoice which includes our bank information, the merchandise total and shipping charges. We will reserve stock for your order for 72 hours on orders awaiting funds. Orders will be canceled after 20 business days if funds have not been received. Customer is responsible for duties and taxes.\n\n'
                                                '6. Sales Tax\n'
                                                'All taxes as under the Indian law is applicable such as VAT, GST charges any other hidden costs will be responsibility of the customers and due at delivery.\n\n'
                                                '7. Product Information\n'
                                                'Semikart makes every effort to provide current and accurate information relating to products and prices, but does not guarantee the currency or accuracy of any such information.Information relating to change of product information is subject to change without prior notice. Prices are subject to change at anytime prior to change at any time prior to the Semikart completetion of order. All prices are in Indian Ruppees.\n\n'
                                                '8. Late Payments And Dishonoured Cheques\n'
                                                'You shall pay to Semikart all costs incurred by Semikart in collecting on any dishonored check or on any past due amount from you, including all court costs, collection costs, and advocate’s fees. All cases are subject to Jurisdiction of Karnataka,India\n\n'
                                                '9. Out Of Stock\n'
                                                'If a Product you order is out of stock at time of order placement, you may elect to have it shipped on a subsequent shipment. Except as otherwise provided on the Site, additional shipping charges will apply to each shipment. Backorders will be held based on your request.\n\n'
                                                '10. Export Compliance\n'
                                                'All orders of international origin or destination are subject to export control laws, restrictions, regulations and orders of the India. You agree to comply with all applicable export control laws, restrictions, regulations and orders from India or applicable foreign agencies or authorities. You shall not, directly or indirectly, sell, export, transfer, transship, assign, use, or dispose of Products in a manner which may result in any non-compliance with applicable export control laws, restrictions, regulations, and orders of India or applicable foreign agencies or authorities. You are responsible for obtaining any license or other official authorizations that may be required to export, re-export or import Products. Diversion contrary to Indian law is prohibited.\n\n'
                                                '11. Return Policy\n'
                                                'In most cases, Semikart will not accept merchandise returns but under special circumstances there will replacement of the Product or refund your money at your option.\n\n'
                                                '12. Product Warranty\n'
                                                'All products are sold on as available basis.Semikart agrees to transfer to you, at the time of sale, to the extent transferable, whatever warranties Semikart receives from manufacturers with respect to the Products sold by Semikart to you. Copies of manufacturer\'s warranty are available prior to purchase and can be accessed from the manufcaturer\'s website.\n\n'
                                                '13. Limited Liability\n'
                                                'In no event shall Semikart is liable for any special, incidental or consequential damages of any nature, including, but not limited to, damages resulting from loss of profit or revenue, recall costs, claims for service interruptions or failure to supply downtime, testing, installation or removal costs, costs of substitute products, property damage, personal injury, death or legal expenses. Customer\'s recovery from Semikart for any claim shall not exceed the purchase price paid by Customer for the goods, irrespective of the nature of the claim, whether in warrant, contract or otherwise. Customers shall indemnify, defend and hold mouser harmless from any claims brought by any other party regarding products supplied by Semikart and incorporated inot the customer\'s product. Products are intended for commercial use only. Products are traceable to the OEM manufacturer and Lot/Date Code where available and when requested at the time of customer order. Semikart does not determine the specifications or conduct any performance or safety testing of any products that it sells. Specification sheets provided to Customers are produced by the manufacturer or transcribed from information provided by the manufacturer. (1) Customer acknowledges that such use or sale is at Customer\'s sole risk; (2) Customer agrees that Semikart and the manufacturer of the Products are not liable, in whole or in part, for any claim or damage arising from such use; and (3) Customer agrees to indemnify, defend and hold Semikart and the manufacturer of the products harmless from and against any and all claims, damages, losses,costs, expenses and liabilities arising out of or in connection with use or sale. If statements or advice, technical or otherwise, are offered or given to Customer, such statements or advice will be deemed to be given as an accommodation to Customer and without charge. Semikart shall have no responsibility or liability for the content or use of such statements or advice. Semikart Technical support is provided by telephone and, therefore, extremely limited in scope which prevents us from the direct participation in the design of any customer products. We do not conduct product suitability studies or engineering reviews of products that we sell, nor for the final product that a Customer produces.\n\n'
                                                '14. Intellectual Property\n'
                                                'If an order includes software or other intellectual property, such software or other intellectual property is provided by Semikart to Customer subject to the copyright and user license, the terms and conditions of which are set forth in the license agreement accompanying such software or other intellectual property. Nothing herein shall be construed to grant any rights or license to use any software or other intellectual property in any manner or for any purpose not expressly permitted by such license agreement. Unopened software may be returned for credit. Opened software may not be returned unless defective.\n\n'
                                                '15. Force Majeure\n'
                                                'Semikart will not be liable for delays in delivery or for failure to perform its obligations due to causes beyond its reasonable control including, but not limited to, product allocations, material shortages, labor disputes, transportation delays, unforeseen circumstances, acts of God, acts or omissions of other parties, acts or omissions of civil or military authorities, Government priorities, fires, strikes, floods, severe weather conditions, computer interruptions, terrorism, epidemics, quarantine restrictions, riots or war. Semikart\'s time for delivery or performance will be extended by the period of such delay or Semikart may, at its option, cancel any order or remaining part thereof, without liability by giving notice to Customer.\n\n'
                                                '16. Standard Delivery\n'
                                                'Provided that Goods are in stock, the Company will use its reasonable endeavours to despatch Goods within 4-6 (four-six) days of date of order. No commitment is given in relation to delivery times achieved. The Company charges a delivery charge of INR 200 (Indian Rupees two hundred only) for orders below INR 5000 (Indian Rupees Five thousand only). The spend amount shall not include value added tax/service tax or any other taxes or any discounts.The Company reserves the right to charge extra for delivery, packing and insurance in transit for all such Goods. Any such charge will be notified to the Customer at the time of placing of the order to which such charge applies. The Company will use reasonable endeavours to meet delivery and/or performance estimates but, except as set out in Condition 8 below, in no circumstances shall it be liable to compensate the Customer for non-delivery, non-performance or late delivery or performance, even where it arises as a result of the negligence of the Company or its carriers. Time for delivery and/or performance shall not be of the essence. Delivery will be made to the address specified by the Customer. The Company may use any method of delivery available to it. The Company reserves the right to deliver or perform by instalments. Failure to meet a Scheduled Delivery or performance date shall not prevent or restrict the Company from making further deliveries or rendering subsequent performance under the relevant Contract by instalment. Scheduled Deliveries can only be accepted for a maximum period of 3 (three) months from the date of order.\n\n'
                                                '17. Inspection, Defects and Non-delivery\n'
                                                'The Customer must inspect the Supplies as soon as practicable after delivery, or in the case of Services, performance, and, except as set out in Condition 14 and/or 15 below, the Company shall not be liable for any defect in the Supplies incomplete or failed delivery, shortage of weight or quality of Supplies unless written notice is given to the Company within 7 days of delivery. The Company does not write software comprised in the Goods and it is the Customer\'s responsibility to check for the presence of computer viruses before such Goods are used. If the Customer receives a damaged parcel, the Customer should take photographs of the parcel to confirm the damage and notify the Company immediately prior to opening the parcel. The quantity of any consignment of Goods as recorded by the Company upon despatch from the Company\'s place of business shall be conclusive evidence of the quantity received by the Customer on delivery, unless the Customer can provide conclusive evidence to the contrary. The Company will not be liable for any non-delivery of Goods or non-performance of Services unless written notice is given to the Company within 7 days of the date when Goods should have been delivered or the Services performed in the ordinary course of events.Any liability of the Company for non-delivery or non-performance or for Goods notified as defective on delivery or Services notified as defective following performance in accordance with this Condition 8 will be limited to, at the Company’s option, replacing the Goods or re-performing the Services within a reasonable time or to refunding the price then paid in respect of such Supplies.\n\n'
                                                '18. Description\n'
                                                'All specifications, drawings, illustrations, descriptions and particulars of weights, dimensions, capacity or other details including, without limitation, any statements regarding compliance with legislation or regulation (together “Descriptions”) wherever they appear (including without limitation in this Catalogue, on despatch notes, invoices or packaging) are intended to give a general idea of the Supplies, but will not form part of the Contract. If the Description of any Goods differs from the manufacturer\'s description, the latter shall be deemed to be correct. The Company shall take all reasonable steps to ensure the accuracy of Descriptions but relies on such information, if any, as may have been provided to it by its suppliers and to the fullest extent permitted by law excludes all liability in contract or tort or under statute or otherwise for any error in or omission from such Descriptions whether caused by the Company\'s negligence or otherwise. The Company may make changes to the Supplies as part of a continuous programme of improvement or to comply with legislation.\n\n'
                                                '19. Risk & Ownership\n'
                                                'The risk of damage to or loss of Goods will pass to the Customer when the Goods are unloaded from the Company\'s carriers at the Customer\'s premises or when Goods are received by the Customer or its representative, whichever is earlier. Ownership of the Goods shall not pass to the Customer until the Company has received in full (in cash or cleared funds) all sums due from the Customer to the Company on any account whatsoever. Until ownership passes to the Customer, the Customer must hold the Goods on a fiduciary basis as the Company\'s bailee, insure the Goods against all usual risks to full replacement value, not pledge or allow any lien, charge or other interest to arise over Goods, and store each delivery of Goods separately, clearly identified as the Company’s property and in a manner to enable them to be identified and cross referenced to particular invoices where reasonably possible. The Customer may use or sell Goods in the ordinary course of business, provided that the Customer will be agent for the Company in any sale if Goods are sold. However any such agency will only extend to the obligation to account for proceeds. The Company will not be bound by any contract between the Customer and the Customer’s purchaser. The Customer must account to the Company for that part of the proceeds of any such sale which equates to the price of the Goods and shall hold that amount in a separate bank account on trust for the Company. The Customer will hold on trust for the Company in a separate bank account any insurance monies received by the Customer for Goods owned by the Company. If payment is not received in full by the due date, or the Customer becomes bankrupt, passes a resolution for winding up or a court shall make an order to that effect, or a receiver is appointed over any assets or the undertaking of the Customer or an execution or distress is levied against the Customer, the Company shall be entitled, without previous notice, to retake possession of the Goods and for that purpose to enter upon any premises occupied or owned by the Customer.\n\n'
                                                '20. Lien\n'
                                                'The Company shall have a general lien in respect of all sums due from the Customer upon all Goods to be supplied to the Customer or upon which work has been done on the Customer\'s behalf and upon 14 (fourteen) days written notice to the Customer, the Company may sell such Goods and apply the proceeds towards the satisfaction of any sums due to the Company.\n\n'
                                                '21. Promotions\n'
                                                'In the event that the Company sends promotional material to the Customer in relation to goods or services available from the Company, these Conditions shall apply to all Supplies purchased from such material.\n\n'
                                                '22. Jurisdiction\n'
                                                'All Contracts shall be governed by the laws of India. The Courts of Bangalore, Karnataka shall have jurisdiction to settle any disputes which may arise out of or in connection with these Conditions or any Contract. By accessing,visiting, browsing, using or interacting or attempting to interact with any part of the site or any software, program or services on the site you agree on your behalf personally and on behalf of any entity for which you are an agent or you represent collectively and individually to each terms and conditions set forth herein (collectively terms of use).\n\n'
                                                '23. Access to the site\n'
                                                'Registration is required to place an order or to use the Site. Select portions of the Site offer expanded Services via the Web through a name/password protected system such as without limitation the Web Services Applications.\n\n'
                                                '24. Technical Assistance\n'
                                                'Semikart offers its technical assistance and applications engineering solely as a convenience to Semikart customers. Semikart technical assistance and applications engineering personnel strive to provide useful information regarding the Products. Semikart does not guarantee that any information or recommendation provided is accurate, complete, or correct, and Semikart shall have no responsibility or liability whatsoever in connection with any information or recommendation provided, or your reliance on such information or recommendation. You are solely responsible for analyzing and determining the appropriateness of any information or recommendation provided by Semikart technical assistance and applications engineering personnel, and any reliance on such information or recommendation is at your sole risk and discretion.\n\n'
                                                '25. Content Inaccuracies\n'
                                                'The Content may contain typographical errors or other errors or inaccuracies and may not be complete or current. Semikart therefore reserves the right to correct any errors, inaccuracies or omissions and to change or update the Content at any time without prior notice. Semikart does not, however, guarantee that any errors, inaccuracies or omissions will be corrected and is not obligated to make such corrections.\n\n'
                                                '26. Support & Links - Third Party\n'
                                                'Hypertext links to third party websites or information do not constitute or imply an endorsement, sponsorship, or recommendation by Semikart of the third party, the third-party website, or the information contained therein, unless expressly stated on the Site. You acknowledge and agree that Semikart is not responsible for the availability of any such websites and that Semikart does not endorse or warrant, and is not responsible or liable for, any such website or the content thereon. You are solely responsible for making your own decisions regarding your interactions or communications with any other website.\n\n'
                                                '27. Advertisements- Third Party\n'
                                                'Any dealings with third parties (including advertisers) included within or available via a link from the Site or participation in promotions, including the delivery of and the payment for goods and services, and any other terms, conditions, warranties or representations associated with such dealings or promotions, are solely between you and the advertiser or other third party. Semikart is not responsible or liable for any part of any such dealings or promotions.\n\n'
                                                '28. Communication Services\n'
                                                'The Site may contain bulletin board services, chat areas, news groups, forums, communities, personal web pages, calendars, and/or other message or communication facilities designed to enable you to communicate with the public at large or with a group (collectively, "Communication Services"). You agree to use the Communication Services only to post, send and receive messages and material that are proper and related to the particular Communication Service. By way of example, and not as a limitation, you agree that when using a Communication Service, you will not:\n\n'
                                                '29. Geographic Limitation\n'
                                                'Like most Internet websites, this Site is accessible worldwide. However, not all Products or Services offered by Semikart are available to all persons or in all geographic locations. Semikart reserves the right to limit the provision of its Products and Services to any person, geographic area, or jurisdiction and to limit the quantities of any Products or Services that it provides. You agree to comply with all applicable laws and local rules regarding the transmission of technical data, acceptable content, and online conduct.\n\n'
                                                '30. Indemnification\n'
                                                'You understand and agree that you are personally responsible for your reliance upon any information or recommendation provided on this Site, its Content, by Semikart technical assistance and applications engineering personnel, and your behavior on the Site. You agree to indemnify, defend and hold harmless Semikart and Semikart\'s joint venturers, business partners, licensors, employees, agents, and any third-party information, Software, and Web Services Application providers to the Site and Services or of the Content from and against all claims, losses, expenses, damages and costs (including, but not limited to, direct, incidental, special, consequential, punitive, exemplary and indirect damages), and reasonable attorneys\' fees, resulting from or arising out of your use, misuse, or inability to use the Site, the Services, or the Content, your reliance upon any information or recommendation provided by Semikart\'s technical assistance and applications engineering personnel, or any violation by you of these Terms of Use.\n\n'
                                                '31. Trade Marks and Logos\n'
                                                'The supplies through the site maybe subject to Industrial property rights patents, knowhow, trademarks, copyright, design rights, utility rights, database rights, circuit layout rights and/or other rights of third parties. No rights, title or licences are granted to the Customer in the Intellectual Property of the Company, except the right to use the Supplies or re-sell the Goods in the Customer\'s ordinary course of business. The Company shall have no liability whatsoever in the event of any claim of infringement of any such rights howsoever arising. You may not use any of the marks or logos appearing throughout the Site without express written consent from the trademark owner, except as permitted by applicable law. All documents, data sheets, notes and product details are third party and SemiKart may not be held wholly responsible for the accuracy.',
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              const SizedBox(height: 18),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    value: localAccepted,
                                                    onChanged: (val) {
                                                      setState(() { localAccepted = val ?? false; });
                                                    },
                                                    activeColor: Color(0xFFA51414),
                                                  ),
                                                  const Text('I accept the Terms & Conditions', style: TextStyle(fontSize: 13)),
                                                ],
                                              ),
                                            ], // <-- This closes the children list for the Column
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text('Cancel', style: TextStyle(color: Colors.white)), // Set Cancel text to white
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFFA51414),
                                            foregroundColor: Colors.white, // Set text color to white
                                          ),
                                          onPressed: localAccepted ? () => Navigator.of(context).pop(true) : null,
                                          child: const Text('Accept'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                            if (accepted == true) {
                              setState(() { isTermsAccepted = true; });
                            }
                          },
                          child: RichText( // Use RichText for clickable "Terms & Conditions"
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenWidth * 0.035, // Adjust font size as needed
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                    color: Color(0xFFA51414), // Make terms link color red
                                    decoration: TextDecoration.underline, // Underline to indicate link
                                  ),
                                  // TODO: Add recognizer to handle tap on "Terms & Conditions"
                                  // recognizer: TapGestureRecognizer()..onTap = () {
                                  //   print("Navigate to Terms & Conditions");
                                  //   // Add navigation logic here
                                  // },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Sign Up Button (uses updated isSignUpButtonActive getter)
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : isSignUpButtonActive
                          ? RedButton(
                              label: "Sign Up",
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.06,
                              onPressed: _signUp,
                            )
                          : InactiveButton(
                              label: "Sign Up",
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.06,
                            ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 30), // Keyboard height + buffer
              ],
            ),
          ),
        ),
      ),
    );
  }
}