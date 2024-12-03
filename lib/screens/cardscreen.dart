import 'package:flutter/material.dart';

import '../servies/firebase_connection.dart';

class CardsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double rating;
  final List<dynamic> reviews;
  final String shippingInformation;
  final double price;

  const CardsScreen({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.shippingInformation,
    super.key, required this.price,
  });

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               IconButton(onPressed: (){
                 Navigator.of(context).pop();

               }, icon: Icon(Icons.arrow_back_ios)),
                Image.network(widget.imageUrl),
                SizedBox(height: 16),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Rating: ${widget.rating}/5', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Description: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(widget.description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Shipping Information: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(widget.shippingInformation, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Reviews:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ...widget.reviews.map<Widget>((review) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['reviewerName'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(review['comment'], style: TextStyle(fontSize: 14)),
                        Text('Rating: ${review['rating']}/5', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                      ],
                    ),
                  );
                }).toList(),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: GestureDetector(
                    onTap: (){

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  databaseconnection(
                          imageUrl: widget.imageUrl,
                          title: widget.title,
                          price: widget.price,
                        ),
                      ));
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text("Add cart  ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w900,color: Colors.yellow),)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
