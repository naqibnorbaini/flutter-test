import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/provider/product_provider.dart';
import 'package:flutter_test_myeg/screens/productDetails.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController _searchController = TextEditingController();
  List _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    if (provider.products.isEmpty) {
      provider.fetchProducts().then((_) {
        setState(() {
          _filteredProducts = provider.products;
        });
      });
    } else {
      _filteredProducts = provider.products;
    }
  }

  void _filterProducts(String query) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final filtered = provider.products.where((product) {
      final title = product.title?.toLowerCase() ?? '';
      return title.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredProducts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.error != null
          ? Center(child: Text(productProvider.error!))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search products...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterProducts('');
                  },
                )
                    : null,
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetails(
                                productId: product.id.toString()),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                        style:
                        TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'RM ${product.price?.toString() ?? 0.0}',
                        style: TextStyle(color: Colors.green[700]),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star,
                              color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text('${product.rating?.rate ?? 0}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
