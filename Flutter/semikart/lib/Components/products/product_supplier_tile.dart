import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductSupplierTile extends StatefulWidget {
  final String supplierLogoUrl;
  final String supplierName;
  final String partStatus;
  final int stock;
  final String packagingType;
  final String vendorPartNumber;
  final String? factoryLeadTime; // Optional
  final String warehouse;
  final String htsCode;
  final String dateCode;
  final int minQuantity;
  final int multQuantity;
  final double initialOrderValue; // Base order value for min quantity
  final List<Map<String, dynamic>> priceSlabs; // e.g., [{'quantity': 1, 'price': 10.0}, {'quantity': 10, 'price': 9.0}]
  final Function(int quantity)? onAddToCart;
  final Function(int quantity)? onRequestQuote;

  const ProductSupplierTile({
    super.key,
    required this.supplierLogoUrl,
    required this.supplierName,
    required this.partStatus,
    required this.stock,
    required this.packagingType,
    required this.vendorPartNumber,
    this.factoryLeadTime,
    required this.warehouse,
    required this.htsCode,
    required this.dateCode,
    required this.minQuantity,
    required this.multQuantity,
    required this.initialOrderValue,
    required this.priceSlabs,
    this.onAddToCart,
    this.onRequestQuote,
  });

  @override
  State<ProductSupplierTile> createState() => _ProductSupplierTileState();
}

class _ProductSupplierTileState extends State<ProductSupplierTile> {
  late TextEditingController _quantityController;
  bool _showPriceSlabs = false;
  String? _quantityError;
  late double _currentOrderValue;
  int _currentQuantity = 0;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.minQuantity;
    _quantityController = TextEditingController(text: _currentQuantity.toString());
    _currentOrderValue = widget.initialOrderValue;
    _quantityController.addListener(_updateQuantityAndValue);
    _validateQuantity(_currentQuantity); // Initial validation
  }

  void _updateQuantityAndValue() {
    final text = _quantityController.text;
    final quantity = int.tryParse(text) ?? 0;
     if (quantity != _currentQuantity) {
        setState(() {
             _currentQuantity = quantity;
            _validateQuantity(quantity);
            _currentOrderValue = _calculateOrderValue(quantity);
        });
     }
  }

  double _calculateOrderValue(int quantity) {
      if (quantity <= 0) return 0.0;
      double pricePerUnit = widget.initialOrderValue / (widget.minQuantity > 0 ? widget.minQuantity : 1); // Default price
      // Find the best price slab
      widget.priceSlabs.sort((a, b) => (a['quantity'] as int).compareTo(b['quantity'] as int)); // Ensure sorted
      for (var slab in widget.priceSlabs.reversed) {
          if (quantity >= (slab['quantity'] as int)) {
              pricePerUnit = slab['price'] as double;
              break;
          }
      }
       // If no slab matched (quantity < smallest slab quantity), use the price from the smallest slab or initial value
      if (widget.priceSlabs.isNotEmpty && quantity < (widget.priceSlabs.first['quantity'] as int)) {
           pricePerUnit = widget.priceSlabs.first['price'] as double;
      }

      return pricePerUnit * quantity;
  }


  void _validateQuantity(int quantity) {
    if (quantity > widget.stock && widget.stock > 0) {
      _quantityError =
          "The entered quantity is more than available. Do you want to request for quote so that we can get back to you?";
    } else if (quantity < widget.minQuantity && quantity != 0) {
       _quantityError = "Minimum order quantity is ${widget.minQuantity}";
    } else if (quantity % widget.multQuantity != 0 && quantity != 0) {
       _quantityError = "Quantity must be a multiple of ${widget.multQuantity}";
    }
     else {
      _quantityError = null;
    }
  }

  @override
  void dispose() {
    _quantityController.removeListener(_updateQuantityAndValue);
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    // Basic responsive scaling factor
    final scaleFactor = screenSize.width / 375; // Assuming 375 is a baseline width

    return Card(
      margin: EdgeInsets.all(8.0 * scaleFactor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0 * scaleFactor),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12.0 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Logo, Name, Status, Stock
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo and Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.supplierLogoUrl,
                      height: 30 * scaleFactor,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.business, size: 30 * scaleFactor),
                    ),
                    SizedBox(height: 4 * scaleFactor),
                    Text(
                      widget.supplierName,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * scaleFactor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Status and Stock
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6 * scaleFactor, vertical: 3 * scaleFactor),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4 * scaleFactor),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: textTheme.bodySmall?.copyWith(fontSize: 11 * scaleFactor),
                          children: [
                            const TextSpan(text: 'Part Status : ', style: TextStyle(color: Colors.black)),
                            TextSpan(
                              text: widget.partStatus,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.partStatus.toLowerCase() == 'active' || widget.partStatus.toLowerCase() == 'new product'
                                    ? Colors.green.shade700
                                    : Colors.orange.shade700, // Example for other statuses
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4 * scaleFactor),
                    Row(
                      children: [
                        Text(
                          'Stock : ',
                          style: textTheme.bodyMedium?.copyWith(fontSize: 12 * scaleFactor),
                        ),
                        Text(
                          '${widget.stock}',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: widget.stock > 0 ? Colors.green.shade700 : Colors.red.shade700,
                            fontSize: 12 * scaleFactor,
                          ),
                        ),
                        SizedBox(width: 2 * scaleFactor),
                        Icon(Icons.info_outline, size: 14 * scaleFactor, color: Colors.grey.shade600),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12 * scaleFactor),

            // Details Grid
            _buildDetailRow(
              context,
              scaleFactor,
              'Packaging Type', widget.packagingType,
              'Vendor Part#', widget.vendorPartNumber,
            ),
            if (widget.factoryLeadTime != null)
              _buildDetailRow(
                context,
                scaleFactor,
                'Factory Lead Time', widget.factoryLeadTime!,
                'Ware House', widget.warehouse, // Moved Warehouse here if Lead Time exists
              ),
             if (widget.factoryLeadTime == null) // Show Warehouse here if Lead Time doesn't exist
                 _buildDetailRow(
                    context,
                    scaleFactor,
                    'Ware House', widget.warehouse,
                    'HTS Code', widget.htsCode,
                 ),
             if (widget.factoryLeadTime != null) // Show HTS Code on its own row if Lead Time exists
                 _buildDetailRow(
                    context,
                    scaleFactor,
                    'HTS Code', widget.htsCode,
                    null, null, // No second item on this row
                 ),


            SizedBox(height: 10 * scaleFactor),

            // Price Slabs Button / Details and Date Code
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       if (!_showPriceSlabs)
                         _buildDetailItem(context, scaleFactor, 'HTS Code', widget.htsCode), // Show HTS here if slabs collapsed and lead time exists
                       SizedBox(height: 8 * scaleFactor),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _showPriceSlabs = !_showPriceSlabs;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red.shade700),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15 * scaleFactor),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12 * scaleFactor, vertical: 6 * scaleFactor),
                        ),
                        child: Text(
                          'Price Slabs',
                          style: TextStyle(color: Colors.red.shade700, fontSize: 12 * scaleFactor),
                        ),
                      ),
                      if (_showPriceSlabs) ...[
                        SizedBox(height: 8 * scaleFactor),
                        ...widget.priceSlabs.map((slab) => Padding(
                              padding: EdgeInsets.only(bottom: 4.0 * scaleFactor),
                              child: Text(
                                '${slab['quantity']}+ | ${slab['price']}',
                                style: textTheme.bodySmall?.copyWith(fontSize: 11 * scaleFactor),
                              ),
                            )),
                      ],
                       SizedBox(height: 10 * scaleFactor),
                       _buildDetailItem(context, scaleFactor, 'Date Code', widget.dateCode),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3, // Give more space to quantity/order value
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        if (_showPriceSlabs)
                            SizedBox(height: 8 * scaleFactor), // Align with expanded slabs
                        // Quantity Input
                        _buildDetailLabel(context, scaleFactor, 'Quantity'),
                        SizedBox(height: 4 * scaleFactor),
                        SizedBox(
                          height: 40 * scaleFactor, // Constrain text field height
                          width: 100 * scaleFactor, // Constrain text field width
                          child: TextField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 8 * scaleFactor),
                              border: const OutlineInputBorder(),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 13 * scaleFactor),
                          ),
                        ),
                        SizedBox(height: 4 * scaleFactor),
                        Text(
                          'Min: ${widget.minQuantity}   Mult: ${widget.multQuantity}',
                          style: textTheme.bodySmall?.copyWith(fontSize: 10 * scaleFactor, color: Colors.grey.shade600),
                        ),
                        SizedBox(height: 10 * scaleFactor),
                         _buildDetailItem(context, scaleFactor, 'Order Value', _currentOrderValue.toStringAsFixed(2)),
                     ],
                  ),
                ),
              ],
            ),


            // Error Message
            if (_quantityError != null)
              Padding(
                padding: EdgeInsets.only(top: 8.0 * scaleFactor),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _quantityError!,
                        style: TextStyle(color: const Color(0xFFA51414), fontSize: 11 * scaleFactor),
                        softWrap: true,
                      ),
                    ),
                    if (_quantityError!.contains("request for quote") && widget.onRequestQuote != null)
                      TextButton(
                        onPressed: () {
                           final quantity = int.tryParse(_quantityController.text) ?? 0;
                           widget.onRequestQuote!(quantity);
                        },
                        child: Text(
                            "Request Quote",
                            style: TextStyle(fontSize: 11 * scaleFactor, color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)
                        ),
                      )
                  ],
                ),
              ),

            SizedBox(height: 12 * scaleFactor),

            // Add to Cart Button
            if (widget.stock > 0 && widget.onAddToCart != null)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (_quantityError == null || _quantityError!.contains("request for quote")) && _currentQuantity > 0
                      ? () {
                          final quantity = int.tryParse(_quantityController.text) ?? 0;
                           if (quantity > 0 && quantity >= widget.minQuantity && quantity % widget.multQuantity == 0) {
                               if (quantity <= widget.stock) {
                                   widget.onAddToCart!(quantity);
                               } else if (widget.onRequestQuote != null) {
                                   // Optionally trigger quote request directly if preferred
                                   // widget.onRequestQuote!(quantity);
                                   // Or just rely on the error message button
                               }
                           } else {
                               // Ensure validation runs even if button is pressed quickly
                               setState(() {
                                   _validateQuantity(quantity);
                               });
                           }
                        }
                      : null, // Disable button if quantity is invalid (and not the quote scenario) or 0
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5 * scaleFactor),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12 * scaleFactor, vertical: 8 * scaleFactor),
                  ),
                  child: Icon(Icons.shopping_cart, size: 18 * scaleFactor),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, double scaleFactor, String label1, String value1, String? label2, String? value2) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0 * scaleFactor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildDetailItem(context, scaleFactor, label1, value1)),
          SizedBox(width: 10 * scaleFactor), // Spacing between columns
          if (label2 != null && value2 != null)
            Expanded(child: _buildDetailItem(context, scaleFactor, label2, value2))
          else
             const Expanded(child: SizedBox()), // Keep alignment if second item is missing
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, double scaleFactor, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDetailLabel(context, scaleFactor, label),
        SizedBox(height: 2 * scaleFactor),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 12 * scaleFactor),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
   Widget _buildDetailLabel(BuildContext context, double scaleFactor, String label) {
       final textTheme = Theme.of(context).textTheme;
       return Text(
         label,
         style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600, fontSize: 11 * scaleFactor),
       );
   }
}