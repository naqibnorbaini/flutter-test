import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/model/ProductListModel.dart';

import '../api.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _service = ProductService();
  List<ProductListModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductListModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _service.fetchProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
