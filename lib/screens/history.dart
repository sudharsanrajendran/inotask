import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getProducts() async {
    QuerySnapshot snapshot = await firestore.collection('orders').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History of Odered Products")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)], // Light blue and cyan
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }


            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available'));
            }
            List<Map<String, dynamic>> products = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  // Safely access fields with null checks and default values
                  String imageUrl = product['imageUrl'] ?? '';
                  String title = product['title'] ?? 'No Title';
                  String description = product['description'] ?? 'No Description';
                  String rating = product['rating']?.toString() ?? 'N/A';
                  String price = product['price']?.toString() ?? '0.0';

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show image only if it exists
                          imageUrl.isNotEmpty
                              ? Image.network(imageUrl)
                              : Container(
                            height: 150,
                            color: Colors.grey[200],
                            child: Center(child: Text('No Image')),
                          ),
                          SizedBox(height: 10),
                          Text(
                            title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(description),
                          SizedBox(height: 10),
                          Text('Rating: $rating/5'),
                          SizedBox(height: 10),
                          Text('Price: \$$price'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
