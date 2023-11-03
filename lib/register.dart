import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class Register extends StatefulWidget {
  const Register({key});
  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Register(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({key});
  //final String title;
  
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

// field forms to send
    String name = '';
    String email = '';
    String phone = '';
    String password = '';

  @override
  Widget build(BuildContext context) {
  
   

    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff125dcf),
        shadowColor: Colors.white,
      //  title: Text(widget.title),
      ),
      body: SizedBox(
        width: screensize.width * 1,
        height: screensize.height * 1,
        child: Container(
            
            color: Colors.white.withOpacity(0.15),
          child: Form(
            key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(25.0, 185.0, 25.0, 0.0),
                children: [ 
                  Image.asset('assets/icoLogin.png'),
                  const SizedBox(height: 10.0,),
                  TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                      decoration: InputDecoration(
                          filled: true,
                        fillColor: Color.fromARGB(255, 208, 208, 210),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                        labelText: 'Nombre',
                        hintText: 'Nombre',
                        
                        
                  //      hintStyle: TextStyle(color:Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido !!!';
                        }else{
                         name = value.toString();
                        }
                        return null;
                      },
                      
                    ),
                    const SizedBox(height: 10.0,),
                     TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                      decoration: InputDecoration(
                          filled: true,
                        fillColor: Color.fromARGB(255, 208, 208, 210),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                        labelText: 'Email',
                        hintText: 'Email',
                        
                  //      hintStyle: TextStyle(color:Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid email !!!';
                        }else{
                          email = value.toString();
                        }
                        return null;
                      },
                      
                    ),
                    const SizedBox(height: 10.0,),
                    TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 208, 208, 210),
                        border: OutlineInputBorder(),
                         contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                        labelText: 'Password',
                        hintText: 'Password'
                      ),
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password !!!';
                        }else {
                          password = value.toString();
                        }
                        return null;
                      },
                    ),
                     const SizedBox(height: 10.0,),
                    TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 208, 208, 210),
                        border: OutlineInputBorder(),
                         contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                        labelText: 'Telefono',
                        hintText: 'Telefono'
                      ),
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese numero de telefono !!!';
                        }else{
                          phone = value.toString();
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 10.0,),
                    ElevatedButton(
                     /*  style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 45, 57, 164))
                      ), */
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          ) ;
//print(name + ' ' + email + ' ' + phone + ' ' + password );
//srv426423.hstgr.cloud
HttpClient httpClient = new HttpClient();
httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

HttpClientRequest request = await httpClient.postUrl(
  Uri.parse('https://srv426423.hstgr.cloud:3000/accounts/create'));
 request.headers.set('content-type','application/json; charset=UTF-8');
request.add(utf8.encode(json.encode({
    'code':'001',
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    'group':'users'
  })));
HttpClientResponse response = await request.close();
print(response.statusCode);
String reply = await response.transform(utf8.decoder).join();
print(reply);
if(response.statusCode == 200){
 
showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("Success"),
      content: Text("Saved successfully"),
      actions: [
        ElevatedButton(onPressed: (){
 Navigator.push(context,MaterialPageRoute(builder: 
            ((context) => const LoginPage()))); 
        }, child: Text("OK")),
      ],
    );
    });
  
} else {
AlertDialog(
  title: Text("Error Registro"),
    content: Text("Hubo un error al registrar la informacion"),
);
} 
                          }
                       //   Navigator.push(context,MaterialPageRoute(builder: 
                        //  ((context) => const RegisterCodePage())));
                        
                      }, child: Text(
                        'Registrar'
                      )),
                /*     const SizedBox(height: 10.0,),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 45, 57, 164))
                      ),
                      onPressed: () {
                     /*   if(_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          ); */
                          Navigator.push(context,MaterialPageRoute(builder: 
                          ((context) => const IntroPage())));
                      //  }
                      }, child: Text(
                        'Regresar'
                      )) */
                  ]
                  
                  )
                
              )
              
            )
            )
          )
    ;
  }
}

