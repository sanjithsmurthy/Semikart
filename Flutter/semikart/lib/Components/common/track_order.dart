import 'package:flutter/material.dart';

class OrderStep {
  final String title;
  final String location;  // This is the parameter name that must be used
  final IconData icon;
  final String? timestamp;

  const OrderStep({
    required this.title,
    required this.location,
    required this.icon,
    this.timestamp,
  });

  static List<OrderStep> getDefaultSteps() {
    return [
      OrderStep(
        title: 'Order Placed',
        location: 'Your order has been placed successfully',
        icon: Icons.shopping_cart_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Order Accepted',
        location: 'Seller has accepted your order',
        icon: Icons.check_circle_outline,
        timestamp: null,
      ),
      OrderStep(
        title: 'Contacted Supplier',
        location: 'Processing with supplier',
        icon: Icons.contact_phone_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'In Transit',
        location: 'Package in international transit',
        icon: Icons.flight_takeoff_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Custom Clearance',
        location: 'Package clearing customs',
        icon: Icons.gavel_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'In Fulfillment Center',
        location: 'Package at local fulfillment center',
        icon: Icons.warehouse_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Shipped',
        location: 'Out for final delivery',
        icon: Icons.local_shipping_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Order Delivered',
        location: 'Package delivered successfully',
        icon: Icons.done_all_outlined,
        timestamp: null,
      ),
    ];
  }
}

class TrackOrder extends StatelessWidget {
  final List<OrderStep> steps;
  final int currentStep;

  const TrackOrder({
    Key? key,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust the container width dynamically based on screen size
    final containerWidth = screenWidth * 0.9; // Use 90% of the screen width

    return Container(
      width: containerWidth, // Dynamically calculated width
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFE4E8EC),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Column(
            children: List.generate(
              steps.length,
              (index) => _buildStep(
                steps[index],
                index,
                isLast: index == steps.length - 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(OrderStep step, int index, {bool isLast = false}) {
    final isCompleted = index <= currentStep;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 95), // Full spacing between circles
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E8EC),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFE4E8EC),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(
                              Icons.check,
                              color: Color(0xFFA51414),
                              size: 24.0,
                            )
                          : null,
                    ),
                  ),
                  if (!isLast)
                    Positioned(
                      top: 50.0, // Starts at bottom edge of circle
                      left: 24.0, // Centers line (50/2)
                      child: IgnorePointer(
                        child: Container(
                          width: 1,
                          height: 95, // Exact length to touch next circle
                          color: isCompleted ? Color(0xFFA51414) : Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA51414),
                  ),
                ),
                if (step.timestamp != null) ...[
                  SizedBox(height: 4.0),
                  Text(
                    step.timestamp!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Product Sans',
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
                if (!isCompleted) ...[
                  SizedBox(height: 7.0),
                  Text(
                    step.location,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}