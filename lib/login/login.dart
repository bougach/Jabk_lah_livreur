import 'package:flutter/material.dart';
import 'package:jabklah_livreur/Componnents/Constante.dart';
import 'package:jabklah_livreur/background/Background.dart';
import 'package:jabklah_livreur/entities/AdminAuthRequest.dart';
import 'package:jabklah_livreur/ordersPage.dart';
import 'package:jabklah_livreur/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    final String username = "${_usernameController.text}:LIVREUR";
    final String password = _passwordController.text;

    final AdminAuthRequest request = AdminAuthRequest(username: username, password: password);

    try {
      final AuthenticationResponse response = await _authService.authenticate(request);
      print('Authentication successful. Token: ${response.token}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);


      Navigator.pushReplacement<dynamic, dynamic>(
        context,
        MaterialPageRoute<dynamic>(builder: (context) {
          return DeliveryScreen();
        }),
      );
    } catch (e) {
      print('Authentication failed: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blueGrey,
                ),
              ),
              Image.asset("assets/imgs/guy.jpg", height: size.height * 0.4),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: PrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: PrimaryColor,
                    ),
                    hintText: "UserName",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: PrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: PrimaryColor,
                    ),
                    suffixIcon: Icon(Icons.visibility, color: PrimaryColor),
                    hintText: " password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: 200.0,
                margin: EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: TextButton(
                    onPressed: _handleLogin,
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateProperty.all<Color>(PrimaryLightColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
                    ),
                    child: Text('login'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
