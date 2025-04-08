import 'package:flutter/material.dart';

class ItemDropdownCard extends StatefulWidget {
  final String mfrPartNumber;
  final String manufacturer;
  final double basicUnitPrice;
  final int quantity;
  final double finalUnitPrice;

  const ItemDropdownCard({
    Key? key,
    required this.mfrPartNumber,
    required this.manufacturer,
    required this.basicUnitPrice,
    required this.quantity,
    required this.finalUnitPrice,
  }) : super(key: key);

  @override
  State<ItemDropdownCard> createState() => _ItemDropdownCardState();
}

class _ItemDropdownCardState extends State<ItemDropdownCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.finalUnitPrice * widget.quantity;
    final shippingFee = 250.0;
    final grandTotal = totalPrice + shippingFee;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: constraints.maxWidth > 400 ? 400 : constraints.maxWidth * 0.95,
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 12.0,
            bottom: isExpanded ? 16.0 : 10.0, // Reduced by 2px when collapsed
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Reduced vertical margin
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Item Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '1. ${widget.mfrPartNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                      '₹${(totalPrice * 1.18 + shippingFee).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: const Color(0xFFA51414),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Detailed breakdown when expanded
              if (isExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _labelValue('Manufacturer', widget.manufacturer),
                    _labelValue('Unit Price', '₹${widget.basicUnitPrice.toStringAsFixed(2)}'),
                    _labelValue('Quantity', widget.quantity.toString()),
                    _labelValue('Subtotal', '₹${totalPrice.toStringAsFixed(2)}'),
                    _labelValue('GST (18%)', '₹${(totalPrice * 0.18).toStringAsFixed(2)}'),
                    const Divider(),
                    _labelValue('Domestic Shipping Fee', '₹${shippingFee.toStringAsFixed(2)}'),
                    const Divider(),
                    _labelValue('Total', '₹${(totalPrice * 1.18 + shippingFee).toStringAsFixed(2)}',
                        highlight: true),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _labelValue(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: highlight ? const Color(0xFFA51414) : Colors.black,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
