import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_login_layout/home_page.dart';
import 'package:flutter_login_layout/register.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({key});
  //final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // field forms to send
  String user = "";
  String password = "";

  Future<void> postUsuarios() async {

    var url = Uri.parse('https://srv426423.hstgr.cloud:3000/accounts/create');
    var response = await http.post(url,
        body: json.encode({
          "name": "",
          "email": "",
          "phone": "",
          "password": password,
          "address": "address123",
          "group": "users",
          "code": "12345",
        }));
    print( 'Respuesta recibida: ${response.statusCode} ${response.reasonPhrase}');
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff125dcf),
        shadowColor: Colors.white,
        title: const Text("Inicio de Sesion"),
      ),
      body: SizedBox(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(25.0, 185.0, 25.0, 0.0),
            children: [
              Image.asset(
                'assets/icoLogin.png',
                width: 1000,
                height: 200,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido !!!';
                  } else {
                    user = value.toString();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido !!!';
                  } else {
                    password = value.toString();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showHomePage(context);
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    //postUsuarios();
                    print(user +  ' ' + password);

                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showRegisterPage(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startLogin(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return HomePage();
    });
    Navigator.of(context).push(route);
  }

  void _showHomePage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return HomePage();
    });
    Navigator.of(context).push(route);
  }

  void _showRegisterPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return RegisterPage();
    });
    Navigator.of(context).push(route);
  }
}
