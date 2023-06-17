import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic_bloc_re_learn/data/model/product/add_product/product_request_model.dart';
import 'package:fic_bloc_re_learn/data/model/product/get_product/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSources {
  Future<Either<String, List<ProductResponseModel>>> getAllProduct() async {
    const baseUrl = "https://api.escuelajs.co/api/v1/products/";
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return Right(
        //take the response and decode it
        //then for every item in list assigned it to ProductResponseModel
        //then convert it to List of ProductResponseModel
        List.from(jsonDecode(response.body))
            .map((e) => ProductResponseModel.fromMap(e))
            .toList(),
      );
    } else {
      return const Left("Failed Fetching Data");
    }
  }

  Future<Either<String, ProductResponseModel>> addProduct(
    ProductRequestModel model,
  ) async {
    const baseUrl = "https://api.escuelajs.co/api/v1/products/";
    final response = await http.post(
      Uri.parse(baseUrl),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed Add Data');
    }
  }

  Future<Either<String, ProductResponseModel>> updateProduct(
    int id,
    ProductRequestModel model,
  ) async {
    final baseUrl = "https://api.escuelajs.co/api/v1/products/$id";
    final response = await http.put(
      Uri.parse(baseUrl),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left("Failed updating product");
    }
  }
}
