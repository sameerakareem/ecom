import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerse/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';


class FavouriteScreen extends StatefulWidget {

  FavouriteScreen({Key? key, })
      : super(key: key);

  @override
  FavouriteScreenListData createState() => FavouriteScreenListData();
}

class FavouriteScreenListData extends State<FavouriteScreen> {

  FavouriteScreenListData();

  @override
  initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              //  Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
            },
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favourites",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
         Expanded(
              child: SizedBox(
                height: MediaQuery.of(context)
                    .size
                    .height, // Provide a height constraint here
                child: _buildProductView_1(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleButtonClick(BuildContext context) {
    Scaffold.of(context).openEndDrawer(); // Open the end drawer
  }

  Widget _buildProductView_1() {

      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  Padding(
                    padding:  EdgeInsets.only(left: 25.0),
                    child: Lottie.asset(
                      'assets/images/emptywishlist.json', // Replace with the path to your Lottie animation file
                      width: 250.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 100,),
                  const Text("No items in favourites!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  // const Text("Your wishlist is currently empty!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  const SizedBox(height: 10,),
                  const Text("Explore more and shortlist some items",style: TextStyle(color: Colors.grey),),
                  const SizedBox(height: 70,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: buttonColor, backgroundColor: Colors.white, // Set the text color
                      elevation: 5, // Set the elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Set the border radius
                        side: const BorderSide(color:buttonColor), // Set the border color
                      ),
                    ),
                    child: const Text("Continue Shopping"),
                  )

                ],
              ),
            )),
      );

  }


}
