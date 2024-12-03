import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/cardscreen.dart';

class Apicalls extends StatefulWidget {
  const Apicalls({super.key});

  @override
  State<Apicalls> createState() => _ApicallsState();
}

class _ApicallsState extends State<Apicalls> {
  List products = [];

  // Fetch data method
  fetchdata() async {
    String url = 'https://dummyjson.com/products';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body)['products'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),

              child: CarouselSlider.builder(itemCount: products.length-1, itemBuilder:(context,index,int){
                final item=products[index];
                return Container(
                  child: ClipRRect(
                      borderRadius:BorderRadius.circular(10),
                      child: Image(image:NetworkImage(item['images'][0]),fit: BoxFit.cover,)),
                );
              }, options:CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  autoPlay: true

              ))
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 250,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                final imageUrl = item['images'] != null && item['images'].isNotEmpty
                    ? item['images'][0]
                    : 'https://via.placeholder.com/150'; // Default image if none found

                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image container with fixed size for better control
                        Expanded(
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Title with overflow handling
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)], // Light blue and cyan
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to CardsScreen and pass data
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CardsScreen(
                                  imageUrl: imageUrl,
                                  title: item['title'],
                                  description: item['description'] ?? 'No description available',
                                  rating: item['rating'],
                                  reviews: item['reviews'] ?? [],
                                  shippingInformation: item['shippingInformation'] ?? 'Not available',
                                  price: item['price'],
                                ),
                              ));
                            },
                            child: Text(
                              '  ADD CART  ',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
