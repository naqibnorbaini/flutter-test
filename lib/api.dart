import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/model/ProductListModel.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductListModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ProductListModel.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}