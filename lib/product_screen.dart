import 'package:ecommerse/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerse/services/download_manager.dart';
import 'package:ecommerse/services/network_response.dart';
import 'package:ecommerse/utils/loading_circle.dart';
import 'package:ecommerse/models/product_model.dart';

class ProductList extends StatefulWidget {
  final int? categoryId;
  final String? title;

  ProductList({
    Key? key,
    this.title,
    required this.categoryId,
  }) : super(key: key);

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductList> {
  List<ProductModel> productModelList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    downloadProductList();
  }

  Future<void> downloadProductList() async {
    try {
      setState(() {
        isLoading = true;
      });
      NetworkResponse<List<ProductModel>> data =
      await DownloadManager.getAllProducts();
      setState(() {
        productModelList = data.response;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductListState(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<ProductListState>(
          builder: (context, state, _) {
            if (isLoading) {
              return Center(
                child: LoadingCircle(),
              );
            } else {
              return _buildProductListView(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductListView(BuildContext context) {
    return ListView.builder(
      itemCount: productModelList.length,
      itemBuilder: (context, index) {
        ProductModel productModel = productModelList[index];
        String firstImage = productModel.images.isNotEmpty
            ? productModel.images.first
            : ''; // Get first image URL
        firstImage = firstImage
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll('"', '');

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProductDetails(
                  productModel: productModel,
                ),
              ));
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          firstImage,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded successfully
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                      null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ??
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
                              fit: BoxFit.cover,
                            ); // Error placeholder
                          },
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Consumer<ProductListState>(
                          builder: (context, state, _) => GestureDetector(
                            onTap: () {
                              state.toggleFavorite(productModel);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: state.isFavorite(productModel)
                                  ? Colors.red
                                  : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${productModel.title?.toUpperCase()}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.currency_rupee,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${productModel.price}",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add any additional widgets here as needed
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProductListState with ChangeNotifier {
  List<ProductModel> _favoriteProducts = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isFavorite(ProductModel productModel) {
    return _favoriteProducts.contains(productModel);
  }

  void toggleFavorite(ProductModel productModel) {
    if (_favoriteProducts.contains(productModel)) {
      _favoriteProducts.remove(productModel);
    } else {
      _favoriteProducts.add(productModel);
    }
    notifyListeners();
  }
}

