// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final String? initialUsername;

  const LoginScreen({this.initialUsername});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialUsername != null) {
      usernameController.text = widget.initialUsername!;
    }
  }

  Future<void> _login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString(username);

    if (storedPassword != null && storedPassword == password) {
      String accountName = prefs.getString('${username}_name') ?? 'No Name';
      String accountEmail = prefs.getString('${username}_email') ?? 'No Email';

      prefs.setBool('isLoggedIn', true);
      prefs.setString('accountName', accountName);
      prefs.setString('accountEmail', accountEmail);
      prefs.setString('username', username);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showErrorDialog('Invalid username or password. Please register if you don\'t have an account.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg1.jpg', // Đường dẫn đến hình nền của bạn
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 213, 119, 230),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text('Login'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var username = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                            if (username != null) {
                              setState(() {
                                usernameController.text = username;
                              });
                            }
                          },
                          child: const Text("Don't have an account? Register"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
