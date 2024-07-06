import 'dart:developer';

import 'package:ecommerse/registation/regisitration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/colors.dart';
import '../login/login_screen.dart';
import 'components/page1.dart';
import 'components/page2.dart';
import 'components/page3.dart';

class WalkThroughScreen extends StatelessWidget {
  WalkThroughScreen({super.key});

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    RxInt onpageChanged = 0.obs;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                  height: 400,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (value) {
                      onpageChanged.value = value;
                    },
                    // reverse: true,
                    children: [Page1(), Page2(), Page3()],
                  )),
              SizedBox(height: 20),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    onpageChanged.value == 0
                        ? Container(
                            width: 80,
                            height: 10,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(5)),
                          )
                        : const CircleAvatar(
                            radius: 5,
                            backgroundColor: grey,
                          ),
                    SizedBox(width: 15),
                    onpageChanged.value == 1
                        ? Container(
                      width: 80,
                      height: 10,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius:
                                    BorderRadius.circular(5)),
                          )
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: grey,
                          ),
                    SizedBox(width: 15),
                    onpageChanged.value == 2
                        ? Container(
                      width: 80,
                      height: 10,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius:
                                    BorderRadius.circular(5)),
                          )
                        : CircleAvatar(
                            radius: 1,
                            backgroundColor: grey,
                          ),
                  ],
                );
              }),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to E Commerce',
                    style: GoogleFonts.poppins(
                        fontSize: 18.px, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Trusted by 4 lakh+ buyers all over India as their best sourcing partner',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 12.px),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                      },
                      child: Container(
                        height: 50,  // Specify a height for consistency
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor,
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.px,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => RegistrationScreen()));
                        },
                      child: Container(
                        height: 50,  // Same height as the 'Login' button
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor,
                        ),
                        child: Center(
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.px,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
