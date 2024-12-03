import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inotask/screens/Home.dart';

class databaseconnection extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;

  const databaseconnection({
    required this.imageUrl,
    required this.title,
    required this.price,
    super.key,
  });

  @override
  State<databaseconnection> createState() => _databaseconnectionState();
}

class _databaseconnectionState extends State<databaseconnection> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int quantity=0;
  addcard()
  {
    setState(() {
      quantity++;
    });

   
  }
  deletecard(){

    setState(() {
      quantity--;
    });
  }



  Future<void> addData() async {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');

    try {
      await orders.add({
        'imageUrl': widget.imageUrl,
        'title': widget.title,
        'price': widget.price,
        'quantity': quantity,
        'totalPrice': widget.price * quantity,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your order has been placed successfully!'),backgroundColor: Colors.green,),
      );

    } catch (error) {
      // If there was an error, display an error message
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('Error: $error'),backgroundColor:Colors.red ,),
      );
    }
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.imageUrl),
              Text(widget.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Price: \$${widget.price}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10,),
              Container
                (
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed:(){
                      addcard();
                    }, icon:Icon(Icons.add)),
                    Text('${quantity}'),
                    IconButton(onPressed:(){
                      addcard();
                    }, icon:Icon(Icons.remove))
                  ],
                ),
              ),

              SizedBox(height: 20),
              GestureDetector(
                onTap:(){
                  if(quantity==0||quantity==null)
                  {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('place enter the value!'),backgroundColor: Colors.black,),
    );
                  }
                  else {
                    addData();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Place order ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w900,color: Colors.yellow),)),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
