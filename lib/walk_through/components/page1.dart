
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/colors.dart';


class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(text: TextSpan(
              children: [
                TextSpan(text: 'Now\n',
                style: GoogleFonts.poppins(fontSize: 21.px,fontWeight: FontWeight.w500,color: black)
                ),
                 TextSpan(text: 'Buy Fast, Sell Faste\n',
                style: GoogleFonts.poppins(fontSize: 21.px,fontWeight: FontWeight.w500,color: buttonColor)
                ),
                 TextSpan(text: 'with Click to Buy',
                style: GoogleFonts.poppins(fontSize: 21.px,fontWeight: FontWeight.w500,color: black
                )
                ),
              ]
            )),
          ),
          SizedBox(height: 30),
          Image.asset('assets/images/walk1.png',height: 250,),
          Spacer(),
        
        ],
      ),
    );
  }}