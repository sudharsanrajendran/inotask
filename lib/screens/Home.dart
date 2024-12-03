import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inotask/seachbar.dart';

import '../servies/api_servies.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController seachcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    var width= MediaQuery.of(context).size.width;
    bool isDesktop() => width >= 700;
    bool isTablet() => width <700 && width >=500;
    bool isMobile() => width > 500;


    return
      Scaffold
        (
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3E5FC), Color(0xFFE0F7FA)], // Light blue and cyan
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.menu),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(backgroundImage:AssetImage('images/avatar.jpeg')),
                      )

                    ],
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Seachbar()));
                      },
                      child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('seach product',style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                 



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Categories...',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w900),),
                  ),

                  Container(
                    child: Apicalls(),
                  )
                ],
              ),
            ),
          ),
        
            ),
      );
  }
}
