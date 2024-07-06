import 'dart:typed_data';
import 'package:ecommerse/models/category_model.dart';
import 'package:ecommerse/product_screen.dart';
import 'package:ecommerse/utils/loading_circle.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  List<CategoryModel> categoryInitalList = [];
  CategoryList({super.key, required this.categoryInitalList});

  @override
  CategoryListData createState() => CategoryListData();
}

class CategoryListData extends State<CategoryList> {
  List<CategoryModel> _categoryModel = [];

  @override
  void initState() {
    super.initState();
    _categoryModel = widget.categoryInitalList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 56,
          ),
          Text(
            "What are You Looking For...?",
            maxLines: 1,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Varela',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Explore Our Top Categories ",
            maxLines: 1,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Varela',
              fontSize: 15,
            ),
          ),
          Expanded(
            child: body(),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return ListView(children: <Widget>[
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: _categoryModel.length,
        itemBuilder: (BuildContext context, int x) {
          CategoryModel categoryModells = _categoryModel[x];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProductList(
                    categoryId: 0,
                  )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: ClipOval(
                    child: FutureBuilder<void>(
                      future: Future.value(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child:
                                  CircularProgressIndicator(), // Loading indicator
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return categoryModells.image != null
                              ? Image.network(
                                  categoryModells.image!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // Image loaded successfully
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/images/noimage.png',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ); // Error placeholder
                                  },
                                )
                              : Image.asset(
                                  'assets/images/noimage.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                );
                        } else {
                          return Image.asset(
                            'assets/images/noimage.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      "${categoryModells.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    ]);
  }
}
