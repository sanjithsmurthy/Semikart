import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ship_bill.dart';

class EditTextBox2 extends StatefulWidget {
  // New parameters for multiple addresses
  final String? title;
  final List<Map<String, String>>? initialAddresses;
  final int? initialSelectedIndex;
  final ValueChanged<List<Map<String, String>>>? onAddressesChanged;
  final ValueChanged<int>? onAddressSelected;

  // Backward compatible parameters
  final String? address1;
  final String? address2;
  final VoidCallback? onEdit;

  const EditTextBox2({
    super.key,
    this.title,
    this.initialAddresses,
    this.initialSelectedIndex,
    this.onAddressesChanged,
    this.onAddressSelected,
    // Backward compatible parameters
    this.address1,
    this.address2,
    this.onEdit,
  });

  @override
  State<EditTextBox2> createState() => _EditTextBox2State();
}

class _EditTextBox2State extends State<EditTextBox2> {
  late List<Map<String, String>> _addresses;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Initialize with backward compatible parameters if provided
    _addresses = widget.initialAddresses ?? [];
    if (widget.address1 != null || widget.address2 != null) {
      _addresses.add({
        'address1': widget.address1 ?? '',
        'address2': widget.address2 ?? '',
      });
    }
    _selectedIndex = widget.initialSelectedIndex ?? (_addresses.isNotEmpty ? 0 : -1);
  }

  void _addNewAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShipBillForm()),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _addresses.add(result);
        _selectedIndex = _addresses.length - 1;
      });
      _notifyChanges();
    }
  }

  void _editAddress(int index) async {
    // For backward compatibility with onEdit
    if (widget.onEdit != null && _addresses.length == 1) {
      widget.onEdit!();
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShipBillForm()),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _addresses[index] = result;
      });
      _notifyChanges();
    }
  }

  void _selectAddress(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onAddressSelected?.call(index);
  }

  void _notifyChanges() {
    widget.onAddressesChanged?.call(_addresses);
  }

  Widget _buildAddressItem(Map<String, String> address, int index) {
    final addressText = '${address['address1'] ?? ''}${address['address1']?.isNotEmpty == true && address['address2']?.isNotEmpty == true ? ', ' : ''}${address['address2'] ?? ''}';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Radio<int>(
            value: index,
            groupValue: _selectedIndex,
            onChanged: (value) => _selectAddress(value!),
            activeColor: const Color(0xFFA51414),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              addressText,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFFA51414)),
            onPressed: () => _editAddress(index),
          ),
        ],
      ),
    );
  }

  // Method to handle adding a copied billing address
  void _addCopiedAddress(Map<String, String> address) {
    setState(() {
      _addresses.add(address);
      _selectedIndex = _addresses.length - 1;
    });
    _notifyChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? 'Shipping Address',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFA51414),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: GestureDetector(
                  onTap: _addNewAddress,
                  child: const Text(
                    'Add new',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_addresses.isEmpty)
            Text(
              'No ${widget.title?.toLowerCase()?.replaceAll(' address', '') ?? 'shipping'} addresses added',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            )
          else
            Column(
              children: [
                ..._addresses.asMap().entries.map(
                      (entry) => _buildAddressItem(entry.value, entry.key),
                    ),
              ],
            ),
        ],
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ShipBillForm(),
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
