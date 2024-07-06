import 'dart:convert';

import 'package:ecommerse/HomePage.dart';
import 'package:ecommerse/favoutite_screen.dart';
import 'package:ecommerse/utils/Toast.dart';
import 'package:ecommerse/utils/colors.dart';
import 'package:ecommerse/utils/exit_confirmation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';


class Home extends StatefulWidget {

  Home({super.key,});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          // Show exit confirmation dialog only on the Home screen
          ExitConfirmationDialog.show(context, (){});
          return false;
        } else {
          // Navigate to the previous screen if not on the Home screen
          return true;
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: getPages(_currentIndex),
        ),
        bottomNavigationBar:  NavigationBar(
          onDestinationSelected: onTabTapped,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: _currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: buttonColor),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite_outlined, color:buttonColor),
              icon: Icon(Icons.favorite_border_rounded),
              label: 'Favourites',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart, color:buttonColor),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color:buttonColor),
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
          height: 60,
          backgroundColor: Colors.white,
        )
      ),
    );
  }

  Widget getPages(int currentIndex) {
    Widget page;
    if (currentIndex == 0) {
      page = const HomePageData();
    } else if (currentIndex == 1) {
       page = FavouriteScreen();

    } else if (currentIndex == 2) {
       page = const CartScreen();
    } else {
      // page = ProfileScreen(/*selectedOrder: savedOrder!, customerModel: customerDetails!,*/);
      page = const Placeholder(); // Replace with a valid widget or your desired default
    }
    return page;
  }


  Future<void> onTabTapped(int index) async {
      setState(() {
        _currentIndex = index;
      });

  }
}

