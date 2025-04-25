import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/product_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.error != null
          ? Center(child: Text(productProvider.error!))
          : ListView.builder(
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: product.image != null
                    ? Image.network(
                  product.image!,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                )
                    : null,
                title: Text(
                  product.title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '\$${product.price?.toStringAsFixed(2) ?? "0.00"}',
                  style: TextStyle(color: Colors.green[700]),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text('${product.rating?.rate ?? 0}'),
                  ],
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
