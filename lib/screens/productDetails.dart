import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/productDetails_provider.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductDetailProvider>(context, listen: false)
        .fetchProductById(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDetailProvider>(context);
    final product = provider.product;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : provider.error != null
              ? Center(child: Text('Error: ${provider.error}'))
              : product == null
                  ? Center(child: Text('No product found'))
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: InteractiveViewer(
                              child: Image.network(
                                product.image ?? '',
                                height: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            product.title ?? '',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'RM ${product.price?.toString() ?? 0.0}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.green[700]),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 4),
                              Text('${product.rating?.rate ?? 0}'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            product.description ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
