import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/search_service.dart';
import '../../app_navigator.dart';

class PartNumberSearchBar extends StatefulWidget {
  final double borderRadius;
  const PartNumberSearchBar({super.key, this.borderRadius = 20.0});

  @override
  State<PartNumberSearchBar> createState() => _PartNumberSearchBarState();
}

class _PartNumberSearchBarState extends State<PartNumberSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final SearchService _searchService = SearchService();
  Timer? _debounceTimer;
  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;
  String _query = '';
  String? _error;

  void _onSearch(String query) {
    _debounceTimer?.cancel();
    setState(() {
      _query = query;
      if (query.isEmpty) {
        _results = [];
        _isLoading = false;
        _error = null;
        return;
      }
    });
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      // Replace with your actual endpoint call for part number search
      final results = await _searchService.searchByPartNumber(query);
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _results = [];
        _isLoading = false;
        _error = 'API error. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double borderRadius = widget.borderRadius;
    return Stack(
      children: [
        Container(
          width: screenWidth * 0.9,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Search by part number',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onChanged: _onSearch,
                ),
              ),
              const Icon(Icons.search, color: Color(0xFFA51414), size: 24),
            ],
          ),
        ),
        if (_query.isNotEmpty && (_isLoading || _results.isNotEmpty || _error != null))
          Positioned(
            left: 0,
            right: 0,
            top: 48,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator(color: Color(0xFFA51414))),
                      )
                    : _error != null
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(child: Text('$_error', style: TextStyle(color: Colors.red))),
                          )
                        : _results.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: Text('No part numbers found.')),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                itemCount: _results.length,
                                separatorBuilder: (context, i) => const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final item = _results[index];
                                  final partNo = item['PartNo'] ?? item['partNumber'] ?? item['part_no'] ?? '';
                                  return ListTile(
                                    dense: true,
                                    title: Text(partNo, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    onTap: () {
                                      // Navigate to product details/teleport page for this part number
                                      AppNavigator.goTo(1, routeName: 'l4', arguments: {
                                        'categoryId': item['categoryId'] ?? item['category_id'],
                                        'partNumber': partNo,
                                        // Add any other required arguments for L4
                                      });
                                    },
                                  );
                                },
                              ),
              ),
            ),
          ),
      ],
    );
  }
}
