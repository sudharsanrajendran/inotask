import 'package:flutter/material.dart';
import 'package:inotask/main.dart';
import 'package:provider/provider.dart';

import '../providers/providerdata.dart';
class welcomescreen extends StatefulWidget {
  const welcomescreen({super.key});

  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen> {
  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<providerdata>(context);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)], // Light blue and cyan
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
      
          ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              Text('Welcome',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Expanded(child: Image(image: AssetImage('images/baloonguy.png'))),
              TextField(
                controller: provider.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  hintText:'Name'
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: provider.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                    hintText:'phone'
                ),

              ),
              SizedBox(height: 20,),
              TextField(
                controller: provider.email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                    hintText:'Email'
                ),
              ),
              SizedBox(height: 20,),



              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNav()));
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Login ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w900,color: Colors.yellow),)),
                ),
              ),
              Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
