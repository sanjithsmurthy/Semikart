import 'dart:async';
import 'package:flutter/material.dart' hide SearchBar;
import '../common/search_bar.dart';
import '../../services/search_service.dart';
import '../../app_navigator.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final SearchService _searchService = SearchService();
  List<CategoryResult> _searchResults = [];
  bool _isLoading = false;
  String _query = '';
  String? _error;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearch(String query) {
    _debounceTimer?.cancel();
    
    setState(() {
      _query = query;
      if (query.isEmpty) {
        _searchResults = [];
        _isLoading = false;
        _error = null;
        return;
      }
    });

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }
  Future<void> _performSearch(String query) async {
    setState(() {
      _query = query;
      _isLoading = true;
      _error = null;
    });
    
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }
    
    try {
      final results = await _searchService.searchCategories(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _error = 'API error. Please try again.';
      });
    }
  }

  Color _levelColor(int level) {
    switch (level) {
      case 1:
        return Colors.blue.shade100;
      case 2:
        return Colors.green.shade100;
      case 3:
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  String _levelLabel(int level) {
    switch (level) {
      case 1:
        return 'L1';
      case 2:
        return 'L2';
      case 3:
        return 'L3';
      default:
        return '';
    }
  }

  // --- Search Overlay Implementation ---
  Widget _buildSearchOverlay() {
    if (!_isLoading && (_query.isEmpty || _searchResults.isEmpty) && _error == null) {
      return const SizedBox.shrink();
    }
    return Positioned(
      left: 0,
      right: 0,
      top: 70, // Adjust based on your SearchBar height
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 320),
          child: _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFA51414)),
                  ),
                )
              : _error != null
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(child: Text(_error!, style: TextStyle(color: Colors.red))),
                    )
                  : _searchResults.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: Text('No products matched the search criteria.')),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: _searchResults.length,
                          separatorBuilder: (context, i) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final result = _searchResults[index];
                            return ListTile(
                              dense: true,
                              minVerticalPadding: 0,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                              leading: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Text(
                                  _levelLabel(result.level),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                ),
                              ),
                              title: Text(
                                result.name,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                // Use new navigation method to ensure back from L4 returns to L1
                                AppNavigator.openProductsL4FromSearch(arguments: {
                                  'categoryId': int.tryParse(result.id) ?? result.id,
                                  'categoryName': result.name,
                                  'l1Name': result.level == 1 ? result.name : '',
                                  'l2Name': result.level == 2 ? result.name : '',
                                });
                              },
                            );
                          },
                        ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.05;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.03;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                hintText: 'Search for categories...',
                borderRadius: screenWidth * 0.05,
                onChanged: _onSearch,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Remove Expanded ListView here, overlay will handle results
            ],
          ),
        ),
        _buildSearchOverlay(),
      ],
    );
  }
}