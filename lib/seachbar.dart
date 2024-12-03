import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Seachbar extends StatefulWidget {
  const Seachbar({super.key});

  @override
  State<Seachbar> createState() => _SeachbarState();
}

class _SeachbarState extends State<Seachbar> {
  late List<Map<String, dynamic>> product = [];
  late List<Map<String, dynamic>> filteritems = [];
  TextEditingController seachcontroller = TextEditingController();

  // Fetch data from the API
  fetchData() async {
    String url = 'https://dummyjson.com/products';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        product = List<Map<String, dynamic>>.from(json.decode(response.body)['products']);
        filteritems = product; 
      });
    } else {
      print('Error fetching data');
    }
  }

  void seachResult() {
    String query = seachcontroller.text.toLowerCase();
    setState(() {
      filteritems = product
          .where((product) => product['title'].toLowerCase().contains(query)) 
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)], // Light blue and cyan
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        child: Column(
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: seachcontroller,
                onChanged: (query) {
                  seachResult();
                },
                decoration: InputDecoration(
                  hintText: 'Search for products...',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Display loading spinner while fetching data
            filteritems.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: filteritems.length,
                itemBuilder: (context, index) {
                  final product = filteritems[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(product['title']),
                        subtitle: Text('Price: \$${product['price']}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
