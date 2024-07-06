import 'package:ecommerse/utils/app_controller.dart';
import 'package:ecommerse/utils/colors.dart';
import 'package:ecommerse/walk_through/walk_through_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';


void main() {
  runApp(Welcomepage());
}

class Welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SignUpSignInScreen(),
      ),
    );
  }
}

class SignUpSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'E Commerce',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
                      child: Image.asset('assets/images/walk2.png',),
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Explore Our Collection',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Dive into our wide range of categories and find exactly what you’re looking for.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if(AppController.getisLogged()==true){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Home()));
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => WalkThroughScreen()));
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'LETS START',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
