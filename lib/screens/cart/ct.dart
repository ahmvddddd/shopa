import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../../controllers/auth/userId_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key,});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  List<dynamic> cartItems = [];
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final UserIdService userIdService = UserIdService();
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    fetchCartItems();
    getCurrentUserId();
  }

  Future<void> fetchCartItems() async {
    final token = await secureStorage.read(
        key: 'token'); 
    final response = await http.get(Uri.parse('http://localhost:3000/api/viewCartProducts'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        cartItems = json.decode(response.body);
      });
    }
  }

  Future<void> removeFromCart(String productId) async {
    await http.post(
      Uri.parse('http://localhost:3000/api/removeFromCart'),
      body: json.encode({
        "userId": currentUserId, 
        "productId": productId
        }),
      headers: {'Content-Type': 'application/json'},
    );
    fetchCartItems();
  }

  Future<void> getCurrentUserId() async {
    final userId = await userIdService.getCurrentUserId();
    setState(() {
      currentUserId = userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return ListTile(
            title: Text(product['productName']),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart, color: Colors.red),
              onPressed: () => removeFromCart(product['_id']),
            ),
          );
        },
      ),
    );
  }
}

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key,});

  @override
  AddToCartPageState createState() => AddToCartPageState();
}

class AddToCartPageState extends State<AddToCartPage> {
  List<dynamic> products = [];
  final UserIdService userIdService = UserIdService();
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
    getCurrentUserId();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://yourapi.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    }
  }

  Future<void> addToCart(String productId) async {
    await http.post(
      Uri.parse('http://localhost:3000/api/addToCart'),
      body: json.encode({
        "userId": currentUserId, 
        "productId": productId, 
        "quantity": 1
        }),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> getCurrentUserId() async {
    final userId = await userIdService.getCurrentUserId();
    setState(() {
      currentUserId = userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add to Cart")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['productName']),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart, color: Colors.green),
              onPressed: () => addToCart(product['_id']),
            ),
          );
        },
      ),
    );
  }
}
