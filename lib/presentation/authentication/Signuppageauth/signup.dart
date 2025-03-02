import 'package:ecommerce_app/presentation/authentication/Loginpageauth/Login_button.dart';
import 'package:ecommerce_app/presentation/authentication/Loginpageauth/loginwithgoogle.dart';
import 'package:ecommerce_app/presentation/authentication/Signuppageauth/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: camel_case_types
class Sign_up extends StatefulWidget {
  @override
  State<Sign_up> createState() => _Sign_up();
}

// ignore: camel_case_types
class _Sign_up extends State<Sign_up> {
  final SigninBloc signinBloc = SigninBloc();
  bool isvisible = false;
  bool _obsuretext = true;
  bool? errorvalue;
  final _formkey = GlobalKey<FormState>();
  var controller_username = TextEditingController();
  var controller_email = TextEditingController();
  var controller_password = TextEditingController();

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? attherateerror;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: BlocConsumer<SigninBloc, SigninState>(
          bloc: signinBloc,
          listener: (context, state) {
            setState(() {
              if (state is UsernamefieldIsEmpty) {
                usernameError = "Username Required";
                errorvalue = true;
              } else if (state is EmailfieldIsEmpty) {
                emailError = "Email Required";
              } else if (state is PasswordfieldIsEmpty) {
                passwordError = "Password Required";
              } else if (state is SuccessfullSignInState) {
                Fluttertoast.showToast(msg: 'SignIn Successfully');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login_button()));
              } else if (state is AlreadyEmailExistState) {
                Fluttertoast.showToast(msg: 'already email exist');
              } else if (state is SignInErrorState) {
                Fluttertoast.showToast(msg: "dhfdfhdfuh");
              } else if (state is AtTheRateNotContainState) {
                attherateerror = "Require @ in Email";
                errorvalue = false;
              }
              // else if (state is GoogleSignInCancelledState) {
              //   Fluttertoast.showToast(msg: "Goole authentication null value");
              // }
            });
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 50),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            controller: controller_username,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              label: Text("Username"),
                              errorText: usernameError,
                              errorStyle: TextStyle(color: Colors.red),
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
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              label: Text("Email"),
                              errorText: errorvalue == true
                                  ? emailError
                                  : attherateerror,
                              errorStyle: TextStyle(color: Colors.red),
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
                                  isvisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              label: Text("Password"),
                              errorText: passwordError,
                              errorStyle: TextStyle(color: Colors.red),
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
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              // Add navigation or action here
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login_button(),
                                      ),
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "→",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 390,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                signinBloc.add(SignInButtonClickedEvent(
                                    username: controller_username.text,
                                    email: controller_email.text,
                                    password: controller_password.text));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400],
                              ),
                              child: Center(
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // Center(
                //   child: Text(
                //     'or signup with social account',
                //     style: TextStyle(fontSize: 15, color: Colors.black),
                //   ),
                // ),
                // SizedBox(height: 20),
                // Center(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           signinBloc.add(GoogleButtonClickedEvent());
                //         },
                //         child: Container(
                //           width: 60,
                //           height: 60,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(25),
                //             border: Border.all(color: Colors.red),
                //             color: Colors.white,
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.all(10),
                //             child: Image.network(
                //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUSKL2F8gOghzLdVGApyBYLZ-ant8KEsNo2DZqLOtzW4ZZkjonnpnv8knoz1wog5cXiaU&usqp=CAU",
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
