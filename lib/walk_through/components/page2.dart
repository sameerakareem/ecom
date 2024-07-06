import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      // color:grey

      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Quick Transaction\n',
                  style: GoogleFonts.poppins(
                      fontSize: 21.px,
                      fontWeight: FontWeight.w500,
                      color: black)),
              TextSpan(
                  text: 'Easy Payment\n',
                  style: GoogleFonts.poppins(
                      fontSize: 21.px,
                      fontWeight: FontWeight.w500,
                      color: buttonColor)),
              TextSpan(
                  text: 'with Click to Buy',
                  style: GoogleFonts.poppins(
                      fontSize: 21.px,
                      fontWeight: FontWeight.w500,
                      color: black)),
            ])),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/walk2.png',
            height: 250,
          ),
        ],
      ),
    );
  }
}
