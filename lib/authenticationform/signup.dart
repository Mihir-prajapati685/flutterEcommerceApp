import 'dart:convert';

import 'package:ecommerce_app/Main_screen.dart';
import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/config.dart';

class Sign_up extends StatefulWidget {
  @override
  State<Sign_up> createState() => _Sign_up();
}

class _Sign_up extends State<Sign_up> {
  bool isvisible = false;
  bool _obsuretext = true;
  final _formkey = GlobalKey<FormState>();
  var controller_username = TextEditingController();
  var controller_email = TextEditingController();
  var controller_password = TextEditingController();

  @override
  void postdataserver() async {
    try {
      if (controller_email.text.isNotEmpty &&
          controller_password.text.isNotEmpty &&
          controller_username.text.isNotEmpty) {
        var reqbody = {
          "email": controller_email.text,
          "password": controller_password.text,
          "username": controller_username.text,
        };
        var response = await http.post(
          Uri.parse("http://192.168.72.194:8000/postregister"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqbody),
        );
        if (response.statusCode == 200) {
          print("Registration successful: ${response.body}");
        } else {
          print("Registration failed: ${response.body}");
        }
      }
    } catch (err) {
      print('Error in server flutter: $err');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      body:SingleChildScrollView(
        child:Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, top: 180),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Create\n",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Account",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 70,

                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: controller_username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFF8A65)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Username"),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: controller_email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFF8A65)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Email"),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: controller_password,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key, color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsuretext = !_obsuretext;
                              isvisible = !isvisible;
                            });
                          },
                          icon: Icon(
                            isvisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFF8A65)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Password"),
                      ),
                      obscureText: _obsuretext,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: 390,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepOrangeAccent, Colors.white70],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            var sharedpref =
                            await SharedPreferences.getInstance();
                            sharedpref.setBool(MyHomePageState.KEYFORM, true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreenState(),
                              ),
                            );
                            postdataserver();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'SignUp',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
