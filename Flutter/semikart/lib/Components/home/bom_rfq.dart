import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import your RedButton
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage

class BomRfqCard extends StatelessWidget {
  const BomRfqCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380,
        height: 330, // Decreased height by 10 pixels
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF46D6D), // 19%
              Color(0xFFA51414), // 100%
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // Smart BOM Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Image.asset(
                    'public/assets/images/RFQ.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Smart BOM",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Product Sans',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Have a BOM ?\nUpload it to Semikart via our Smart BOM tool and instantly get prices from multiple suppliers.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Product Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: RedButton(
                label: "Go to BOM",
                onPressed: () {
                  // Handle BOM button tap
                },
                width: 90,
                height: 30,
                isWhiteButton: true,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 335,
                height: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // RFQ Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Image.asset(
                    'public/assets/images/RFQ.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Request For Quote",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Product Sans',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Looking for the best price?\nNeed a larger quantity?\nOr do you have a target price that none of our competitors can match?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Product Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: RedButton(
                label: "Submit RFQ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RFQFullPage()),
                  );
                },
                width: 90,
                height: 30,
                isWhiteButton: true,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
