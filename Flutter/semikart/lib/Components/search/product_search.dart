import 'dart:async';
import 'package:flutter/material.dart' hide SearchBar;
import '../common/search_bar.dart';
import '../../services/search_service.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.05;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.03;

    return Padding(
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
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
                    : _query.isEmpty
                        ? Center(child: Text('Type to search categories'))
                        : _searchResults.isEmpty
                            ? Center(child: Text('No products matched the search criteria.'))
                            : ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  final result = _searchResults[index];
                                  return Card(
                                    color: _levelColor(result.level),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Text(_levelLabel(result.level), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      title: Text(result.name),
                                      subtitle: Text('ID: ${result.id}'),
                                      onTap: () {
                                        // TODO: Implement navigation to category page
                                      },
                                    ),
                                  );
                                },
                              ),
          ),
        ],
      ),
    );
  }
}