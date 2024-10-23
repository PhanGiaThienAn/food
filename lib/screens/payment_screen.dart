// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'home_screen.dart';  // Import the HomeScreen widget

class PaymentScreen extends StatefulWidget {
  final VoidCallback onCheckout;

  const PaymentScreen({super.key, required this.onCheckout});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  String _selectedShippingMethod = 'Standard Shipping';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color.fromARGB(255, 185, 133, 217),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Method:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Card(
                color: Colors.purple[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    _selectedPaymentMethod,
                    style: TextStyle(color: Colors.purple[800], fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: _showPaymentMethodDialog,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Shipping Method:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Card(
                color: Colors.purple[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    _selectedShippingMethod,
                    style: TextStyle(color: Colors.purple[800], fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: _showShippingMethodDialog,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Discount Code',
                  hintText: 'Enter your discount code',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle payment processing here
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 195, 132, 235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Proceed to Pay'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Payment Method'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _paymentMethodOption('Credit Card'),
                _paymentMethodOption('PayPal'),
                _paymentMethodOption('Bank Transfer'),
                _paymentMethodOption('Cash on Delivery'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _paymentMethodOption(String method) {
    return ListTile(
      title: Text(method),
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showShippingMethodDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Shipping Method'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _shippingMethodOption('Standard Shipping'),
                _shippingMethodOption('Express Shipping'),
                _shippingMethodOption('Pickup'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _shippingMethodOption(String method) {
    return ListTile(
      title: Text(method),
      onTap: () {
        setState(() {
          _selectedShippingMethod = method;
        });
        Navigator.pop(context);
      },
    );
  }
}
