import 'package:flutter/material.dart';
import '../Commons/red_button.dart'; // Import the RedButton component

class DynamicTable extends StatefulWidget {
  const DynamicTable({super.key});

  @override
  _DynamicTableState createState() => _DynamicTableState();
}

class _DynamicTableState extends State<DynamicTable> {
  // Start with one empty row by default
  List<Map<String, String>> rows = [
    {"manufacturerPartNo": "", "customerPartNo": "", "quantity": ""},
  ];

  void addRow() {
    setState(() {
      rows.add({"manufacturerPartNo": "", "customerPartNo": "", "quantity": ""});
    });
  }

  void deleteRow(int index) {
    setState(() {
      rows.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table with border
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add border around the table
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "SL.No",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), // Reduced font size
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Manufacturers Part No*",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), // Reduced font size
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Customer Part No*",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), // Reduced font size
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Quantity*",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), // Reduced font size
                        ),
                      ),
                      SizedBox(width: 40), // Space for the delete button
                    ],
                  ),
                ),
                const Divider(height: 1, color: Colors.grey), // Divider between header and rows
                // Table Rows
                ListView.builder(
                  shrinkWrap: true, // Ensure the ListView doesn't expand infinitely
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling for rows
                  itemCount: rows.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Row(
                        children: [
                          // Serial Number
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${index + 1}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12), // Reduced font size
                            ),
                          ),
                          // Manufacturer Part No Input
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              ),
                              onChanged: (value) {
                                rows[index]["manufacturerPartNo"] = value;
                              },
                              controller: TextEditingController(text: rows[index]["manufacturerPartNo"]),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          // Customer Part No Input
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              ),
                              onChanged: (value) {
                                rows[index]["customerPartNo"] = value;
                              },
                              controller: TextEditingController(text: rows[index]["customerPartNo"]),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          // Quantity Input
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              ),
                              onChanged: (value) {
                                rows[index]["quantity"] = value;
                              },
                              controller: TextEditingController(text: rows[index]["quantity"]),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          // Delete Button (only for rows other than the first one)
                          if (index != 0)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFFA51414)),
                              onPressed: () => deleteRow(index),
                              iconSize: 20, // Reduced icon size
                            )
                          else
                            const SizedBox(width: 40), // Placeholder for the delete button
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Add Row Button
              RedButton(
                label: "Add Row",
                onPressed: addRow,
                isWhiteButton: true, // Use the white button variant
                width: 100, // Reduced button width
                height: 36, // Reduced button height
              ),
              // Proceed Button
              RedButton(
                label: "Proceed",
                onPressed: () {
                  // Add your proceed action here
                  print("Proceed button pressed");
                },
                isWhiteButton: false, // Default red button
                width: 100, // Reduced button width
                height: 36, // Reduced button height
              ),
            ],
          ),
        ],
      ),
    );
  }
}