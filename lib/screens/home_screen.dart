// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thien_an/components/product_item.dart';
import '../data/product_data.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'change_password_screen.dart';
import 'add_product_screen.dart';
import 'cart_screen.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> cartProducts = [];
  String searchQuery = '';
  String accountName = 'Loading...';
  String accountEmail = 'Loading...';
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accountName = prefs.getString('accountName') ?? 'No Name';
      accountEmail = prefs.getString('accountEmail') ?? 'No Email';
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _addOrEditProduct(Product? product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductScreen(product: product),
      ),
    );

    if (result != null && result is Product) {
      setState(() {
        if (product != null) {
          final index = products.indexWhere((p) => p.name == product.name);
          products[index] = result;
        } else {
          products.add(result);
        }
      });
    }
  }

  void _deleteProduct(String name) {
    setState(() {
      products.removeWhere((product) => product.name == name);
    });
  }

  void _increaseQuantity(Product product) {
    setState(() {
      product.quantity += 1;
    });
  }

  void _decreaseQuantity(Product product) {
    if (product.quantity > 0) {
      setState(() {
        product.quantity -= 1;
      });
    }
  }

  void _addToCart(Product product) {
    if (product.quantity > 0) {
      setState(() {
        if (cartProducts.contains(product)) {
          final index = cartProducts.indexOf(product);
          cartProducts[index].quantity += product.quantity;
        } else {
          cartProducts.add(product);
        }
      });
    }
  }

  void _removeFromCart(Product product) {
    setState(() {
      cartProducts.remove(product);
    });
  }

  void _checkout() {
    setState(() {
      cartProducts.clear();
    });
    Navigator.pop(context);
  }

  int _getTotalCartQuantity() {
    return cartProducts.fold(0, (total, product) => total + product.quantity);
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          Container(
            width: 56, // Giới hạn chiều rộng để tránh tràn
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          cartProducts: cartProducts,
                          onCheckout: _checkout,
                          onRemoveFromCart: _removeFromCart,
                        ),
                      ),
                    );
                  },
                ),
                if (_getTotalCartQuantity() > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        _getTotalCartQuantity().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 40.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 179, 88, 189),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Z",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(
                      onPasswordChanged: (String newPassword) {
                        setState(() {
                          // cập nhật trạng thái nếu cần thiết
                        });
                      },
                      username: username,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              ...filteredProducts
                  .map((product) => ProductItem(
                        product: product,
                        onEdit: () => _addOrEditProduct(product),
                        onDelete: () => _deleteProduct(product.name),
                        onIncrease: () => _increaseQuantity(product),
                        onDecrease: () => _decreaseQuantity(product),
                        onAddToCart: () => _addToCart(product),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditProduct(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
