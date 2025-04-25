import 'package:flutter/material.dart';

import '../api.dart';
import '../model/ProductListModel.dart';


class ProductDetailProvider with ChangeNotifier {
  final ProductService _service = ProductService();
  ProductListModel? _product;
  bool _isLoading = false;
  String? _error;

  ProductListModel? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProductById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _product = await _service.fetchProductDetails(id);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
