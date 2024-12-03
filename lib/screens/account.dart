import 'package:flutter/material.dart';
import 'package:inotask/providers/providerdata.dart';
import 'package:provider/provider.dart';
class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {

    final provider =Provider.of<providerdata>(context);
    return  Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)], // Light blue and cyan
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),

          ),
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(10.0), // Padding for the ListView itself
            children: [
              SizedBox(height: 200,),
              CircleAvatar(backgroundImage:AssetImage('images/avatarino.jpeg'),radius: 70,),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0), // Add margin between cards
                color: Colors.grey[300], // Lighter grey for a subtle look
                elevation: 5, // Card shadow
                child: Padding(
                  padding: EdgeInsets.all(16.0), // Padding inside the card
                  child: Text(
                    'Name:${provider.name.text}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.grey[300],
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'phone:${provider.phone.text}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.grey[300],
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'eamil:${provider.email.text}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 100,),

              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text("Logout  ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w900,color: Colors.yellow),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
