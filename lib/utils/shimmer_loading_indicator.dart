import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingImage extends StatelessWidget {
  final double height;
  final double width;
  ShimmerLoadingImage({required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width / 2,
        color: Colors.white, // You can set this color to match your background
      ),
    );
  }
}