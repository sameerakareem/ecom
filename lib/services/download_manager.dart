
import 'dart:convert';

import 'package:ecommerse/models/category_model.dart';
import 'package:ecommerse/models/product_model.dart';
import 'package:ecommerse/services/network_response.dart';

import '../utils/utls.dart';
import 'api_service.dart';

class DownloadManager{

  static Future<NetworkResponse<List<CategoryModel>>> getCategory(
     ) async {
    String endPoint = "${Urls.categoryList}";

    final response = await ApiRequestManager.get(endPoint);
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> list = jsonDecode(response.body);
      List<CategoryModel> category =
      list.map((e) => CategoryModel.fromJson(e)).toList();
      return NetworkResponse.success(category);
    } else {
      return NetworkResponse.error(response.body, response: []);

    }
  }

  static Future<NetworkResponse<List<ProductModel>>> getAllProducts(
      ) async {
    String endPoint = "${Urls.getAllProductList}";

    final response = await ApiRequestManager.get(endPoint);
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> list = jsonDecode(response.body);
      List<ProductModel> productModel =
      list.map((e) => ProductModel.fromJson(e)).toList();
      return NetworkResponse.success(productModel);
    } else {
      return NetworkResponse.error(response.body, response: []);

    }
  }

}