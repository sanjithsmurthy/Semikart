import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Replace Firebase with Dio for API calls
import '../services/database.dart'; // Import the DataBaseService instead of FirestoreHelper

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _l1IdController = TextEditingController();
  final TextEditingController _l2NamesController = TextEditingController();
  bool _isLoading = false;
  List<Map<String, dynamic>> _l1Categories = []; // Changed from DocumentSnapshot to Map
  final DataBaseService _databaseService = DataBaseService(); // API service

  @override
  void initState() {
    super.initState();
    _loadL1Categories();
  }

  Future<void> _loadL1Categories() async {
    try {
      // Use the database service to get L1 categories instead of Firebase
      final categories = await _databaseService.getL1Products();
      setState(() {
        _l1Categories = categories;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading categories: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add L2 Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Display existing L1 categories
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available L1 Categories:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _l1Categories.isEmpty
                        ? const Text('Loading categories...')
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _l1Categories.length,
                            itemBuilder: (context, index) {
                              final data = _l1Categories[index];
                              final name = data['name'] ?? 'Unknown';
                              final id = data['id']?.toString() ?? ''; // API response structure
                              return ListTile(
                                title: Text(name),
                                subtitle: Text('ID: $id'),
                                onTap: () {
                                  _l1IdController.text = id;
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Form to add L2 categories
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _l1IdController,
                    decoration: const InputDecoration(
                      labelText: 'L1 Category ID',
                      border: OutlineInputBorder(),
                      helperText: 'Click on a category above to auto-fill',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter L1 category ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _l2NamesController,
                    decoration: const InputDecoration(
                      labelText: 'L2 Category Names (comma separated)',
                      border: OutlineInputBorder(),
                      helperText: 'Example: Electronics, Phones, Laptops',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter L2 category names';
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                final l1Id = _l1IdController.text.trim();
                                final l2Names = _l2NamesController.text
                                    .split(',')
                                    .map((e) => e.trim())
                                    .where((e) => e.isNotEmpty)
                                    .toList();

                                // Add a method to DataBaseService to handle this operation
                                await _addL2Categories(l1Id, l2Names);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added ${l2Names.length} L2 categories!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Clear form
                                _l2NamesController.clear();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('ADD L2 CATEGORIES'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // New method to add L2 categories using the API
  Future<void> _addL2Categories(String l1Id, List<String> names) async {
    for (final name in names) {
      try {
        await _databaseService.addL2Category(l1Id: l1Id, name: name);
      } catch (e) {
        // Continue with other categories if one fails
        print('Error adding L2 category "$name": $e');
      }
    }
  }

  @override
  void dispose() {
    _l1IdController.dispose();
    _l2NamesController.dispose();
    super.dispose();
  }
}