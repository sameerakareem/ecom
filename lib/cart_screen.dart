import 'package:ecommerse/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Lottie.asset(
              'assets/images/cartemp.json',
              width: 200.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Your Shopping cart looks empty!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Let's add some items to the cart to shop",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: buttonColor, backgroundColor:Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10),
                  side: const BorderSide(
                      color:buttonColor),
                ),
              ),
              child: const Text("Continue Shopping"),
            )
          ],
        ),
      ),
    );
  }

}