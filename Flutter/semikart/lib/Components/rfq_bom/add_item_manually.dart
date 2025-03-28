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
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.25; // Button width is 25% of screen width
    final buttonHeight = screenWidth * 0.08; // Button height is 8% of screen width
    final fontSize = screenWidth * 0.035; // Font size scales with screen width
    final padding = screenWidth * 0.02; // Dynamic padding for responsiveness

    return Padding(
      padding: EdgeInsets.all(padding),
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
                  padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize), // Scaled font size
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Mfr Part No",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize), // Scaled font size
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Cust Part No",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize), // Scaled font size
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Quantity*",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize), // Scaled font size
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.1), // Space for the delete button
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
                      padding: EdgeInsets.symmetric(vertical: padding / 2, horizontal: padding),
                      child: Row(
                        children: [
                          // Serial Number
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${index + 1}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: fontSize), // Scaled font size
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
                          SizedBox(width: padding),
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
                          SizedBox(width: padding),
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
                          SizedBox(width: padding),
                          // Delete Button (only for rows other than the first one)
                          if (index != 0)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFFA51414)),
                              onPressed: () => deleteRow(index),
                              iconSize: fontSize * 1.5, // Scaled icon size
                            )
                          else
                            SizedBox(width: screenWidth * 0.1), // Placeholder for the delete button
                        ],
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Colors.grey), // Divider before the Add Row button
                // Add Row Button
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align button to the right
                    children: [
                      RedButton(
                        label: "Add Row",
                        onPressed: addRow,
                        isWhiteButton: true, // Use the white button variant
                        width: buttonWidth, // Scaled button width
                        height: buttonHeight, // Scaled button height
                        fontSize: fontSize, // Scaled font size
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: padding * 2),
          // Proceed Button
          Align(
            alignment: Alignment.centerRight,
            child: RedButton(
              label: "Proceed",
              onPressed: () {
                // Add your proceed action here
                print("Proceed button pressed");
              },
              isWhiteButton: false, // Default red button
              width: buttonWidth, // Scaled button width
              height: buttonHeight, // Scaled button height
              fontSize: fontSize, // Scaled font size
            ),
          ),
        ],
      ),
    );
  }
}