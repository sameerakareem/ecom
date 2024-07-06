import 'package:ecommerse/product_screen.dart';
import 'package:ecommerse/services/download_manager.dart';
import 'package:ecommerse/services/network_response.dart';
import 'package:ecommerse/utils/colors.dart';
import 'package:ecommerse/utils/loading_circle.dart';
import 'package:ecommerse/utils/shimmer_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'category_screen.dart';
import 'models/category_model.dart';

class HomePageData extends StatefulWidget {
  const HomePageData({super.key});

  @override
  HomePageDataState createState() => HomePageDataState();
}

class HomePageDataState extends State<HomePageData> {
  List<CategoryModel> _categoryModel = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllCategorys();
  }

  Future getAllCategorys() async {
    _categoryModel = [];
    isLoading = true;
    NetworkResponse<List<CategoryModel>> data =
        await DownloadManager.getCategory();
    _categoryModel = data.response;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              // width: 50,
              color: chatColor,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // sizedBoxHeight50,

                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Search your products...',
                              style: GoogleFonts.poppins(
                                  color: grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.px),
                            ),
                            Spacer(),
                            Icon(
                              Icons.search,
                              color: buttonColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16.px),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CategoryList(
                          categoryInitalList: _categoryModel,
                        ),
                      ));
                    },
                    child: Text(
                      'SeeAll',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.px,
                          color: chatColor,
                          decorationColor: chatColor,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
            isLoading ? Center(child: LoadingCircle()) : _categoryList(),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                  onTap: () {
                    //Get.to(()=>const FlashSaleScreen());
                  },
                  child: Image.asset('assets/images/homeban1.png')),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ProductList(
                              categoryId: 0,
                            )));
                  },
                  child: Image.asset('assets/images/homeban2.png')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryList() {
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _categoryModel.length,
        itemBuilder: (BuildContext context, int index) {
          CategoryModel categoryModel = _categoryModel[index];
          return CategoryItemView(categoryModel: categoryModel, widget: widget);
        },
      ),
    );
  }
}

class CategoryItemView extends StatelessWidget {
  const CategoryItemView({
    super.key,
    required this.categoryModel,
    required this.widget,
  });

  final CategoryModel categoryModel;
  final HomePageData widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProductList(
                  categoryId: 0,
                )));
          },
          child: Container(
              margin: const EdgeInsets.all(10),
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: ClipOval(
                child: FutureBuilder<void>(
                  future: Future.value(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child:
                              CircularProgressIndicator(), // Loading indicator
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return categoryModel.image != null
                          ? Image.network(
                              categoryModel.image!,
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/images/noimage.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/images/noimage.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            );
                    } else {
                      // Optional: handle other states such as error
                      return Image.asset(
                        'assets/images/noimage.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
              )),
        ),
        Expanded(
          child: Container(
            width: 80,
            child: Text(
              "${categoryModel.name}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
