import 'package:flutter/material.dart';
import 'package:flutter_login_layout/components/getlogin.dart';
import 'package:flutter_login_layout/pages/homepage.dart';
import 'package:flutter_login_layout/pages/register.dart';
import 'package:http/http.dart';



class Login extends StatefulWidget {
  const Login({key});
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Login(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({key});
  //final String title;
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  String username = '';
  String password = '';
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 93, 207),
        shadowColor: Colors.white,
     //   title: Text(widget.title),
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
                        labelText: 'Email',
                        hintText: 'Enter valid email',
                        
                  //      hintStyle: TextStyle(color:Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid email !!!';
                        }else{
                          username = value.toString();
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
                        hintText: 'Enter secure password'
                      ),
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password !!!';
                        }else{
                          password = value.toString();
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 10.0,),
                    ElevatedButton(
                    
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          GetLogin login = new GetLogin();
                          if (await login.getAccess(username, password)) {
                            print('Access');
                             Navigator.push(context,MaterialPageRoute(builder: 
                          ((context) =>  HomePage())));
                          } else {
                            print('Error access');
                          }
                      /*     Navigator.push(context,MaterialPageRoute(builder: 
                          ((context) => const MenuScreen()))); */
                        }
                      }, child: Text(
                        'Login'
                      )),ElevatedButton(
                    
                      onPressed: ()  {
                        
                         Navigator.push(context,MaterialPageRoute(builder: 
                          ((context) => const RegisterPage())));
                      }, child: Text(
                        'Register'
                      ))
                  
                  ]
                  )
                
              )
              
            )
            )
          );
  }

}

