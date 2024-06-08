import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Dashboard.dart';
import 'baseurl.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool check = false;
  late String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 300,
              width: 200,
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Username'),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      logintry();
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      print(_emailController.text);
      print(_passwordController.text);

      var url = Uri.parse('${BaseUrl.baseUrl}/auth/login');
      var body = json.encode({
        "email": _emailController.text,
        "password": _passwordController.text,
      });

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
              height: 100,
              child: Center(child: Text("Logged in successfully")),
            ),
          );
        });
        print("Login successful");

        setState(() {
          check = true;
        });

      } else {
        print("Login failed with status: ${response.statusCode}");
      }
      print('Response body: ${response.body}');
      setState(() {
        token = jsonDecode(response.body)['token'];
      });
      print('Response token: ${token}');
    } catch (e) {
      print('Error during login: $e');
    }
  }

  Future<void> logintry() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await login();
    Navigator.of(context).pop();
    check? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardPage())):
    print("error");
  }
}
