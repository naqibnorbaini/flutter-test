import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/model/ProductListModel.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductListModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ProductListModel.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<ProductListModel> fetchProductDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body); // This is a single product
      return ProductListModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}