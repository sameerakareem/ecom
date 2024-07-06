import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerse/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/product_model.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;
  ProductDetails({Key? key, required this.productModel}) : super(key: key);

  @override
  ProductDetailsData createState() => ProductDetailsData(productModel);
}

class ProductDetailsData extends State<ProductDetails> {
  ProductModel productModel;
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  int qty = 1;

  bool isLoading = false;

  ProductDetailsData(this.productModel);

  @override
  initState() {
    super.initState();
    priceController.text = productModel.price.toString();
    print(productModel.images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
            //    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const ProductView()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add your favorite action here
            },
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 270,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    // Optional callback for page change
                  },
                ),
                items: productModel.images.map((image) {
                  image = image
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll('"', '');
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Text("${productModel.title?.toUpperCase()}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              Row(
                children: [
                  const SizedBox(
                      width: 1), // Add spacing between the icon and TextField
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.currency_rupee,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: priceController.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    decrementQty(setState);
                                  },
                                  color: buttonColor,
                                  child: Text(
                                    "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 50,
                                color: Colors.white,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: Colors
                                              .grey), // Set border color here
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: qtyController,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  enabled: false,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    incrementQty(setState);
                                  },
                                  color: buttonColor,
                                  child: Text(
                                    "+",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Product Details :",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 4),
              Text(
                "${productModel.description}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 1.0, color: Colors.grey), // Example border style
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 39.0, // Set the desired height
                width: 150.0, // Set the desired width
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: buttonColor,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                          color: Colors.grey), // Border color and width
                    ),
                  ),
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: buttonColor,
                    size: 30.0,
                  ),
                  label: const Text('Add to Cart'),
                ),
              ),
              SizedBox(
                height: 39.0, // Set the desired height
                width: 150.0, // Set the desired width
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.arrow_circle_right_sharp,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: const Text('Buy Now'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: buttonColor, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                          color: Colors.grey), // Border color and width
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void incrementQty(StateSetter setState) {
    setState(() {
      qty++;
      qtyController.text = qty.toString();
    });
  }

  void decrementQty(StateSetter setState) {
    if (qty > 1) {
      setState(() {
        qty--;
        qtyController.text = qty.toString();
      });
    }
  }
}
