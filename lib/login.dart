import 'dart:convert';
import 'package:crm_application/Dashboard.dart';
import 'package:crm_application/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth = screenWidth < 600 ? screenWidth * 0.8 : 400;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.cyan],
          ),),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Login to CRM Application',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: boxWidth,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      child: Column(

                        children: [
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
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
                    )],
                )

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
    check?
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardPage())):
    print("error");
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CampaignResults())):
    //     print("error");
  }
}
