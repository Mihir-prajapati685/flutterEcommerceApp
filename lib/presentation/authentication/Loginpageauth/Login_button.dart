import 'package:ecommerce_app/presentation/authentication/Loginpageauth/bloc/login_bloc_bloc.dart';
import 'package:ecommerce_app/presentation/authentication/forgotpassauth/forgotpasswor.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_button extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<Login_button> {
  final LoginBlocBloc loginbloc = LoginBlocBloc();
  final _formKey = GlobalKey<FormState>();
  bool isvisible = false;
  bool _obsuretext = true;

  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();

  String? emailError;
  String? passError; // To store email validation error

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
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
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: BlocListener<LoginBlocBloc, LoginBlocState>(
                        bloc: loginbloc,
                        listener: (context, state) {
                          if (state is LoginUsernameEmptyStateError ||
                              state is LoginPasswordEmptyStateError) {
                            if (state is LoginUsernameEmptyStateError) {
                              setState(() {
                                emailError = state.errormessage1;
                              });
                            } else if (state is LoginPasswordEmptyStateError) {
                              setState(() {
                                passError = state.passerror;
                              });
                            }
                          } else if (state
                              is LoginUsernameNotContainStateError) {
                            setState(() {
                              emailError = state.errormessage2;
                            });
                          } else if (state
                              is LoginUsernameOneCharatorTextfeildSucessState) {
                            setState(() {
                              emailError = null;
                            });
                          } else if (state
                              is LoginUsernameTextfeildSucessState) {
                            setState(() {
                              emailError = null;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreenState()),
                            );
                            Fluttertoast.showToast(
                              msg: "Login Sucessfully",
                            );
                          } else if (state is GoogleSignInCancelledState) {
                            Fluttertoast.showToast(msg: "Google Login cancel");
                          } else if (state is SuccessfullGoogleSignInState) {
                            Fluttertoast.showToast(
                                msg: "Google Login Sucessfully");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => MainScreenState()));
                          } else if (state is EmailNotMatchState) {
                            Fluttertoast.showToast(msg: "Email Not match");
                          } else if (state is PasswordNotMatchState) {
                            Fluttertoast.showToast(msg: "Password not match");
                          }
                        },
                        child: TextFormField(
                          onChanged: (value) {
                            loginbloc.add(LoginOneCharactorAccessEvent(
                                getcharEmail: value));
                          },
                          controller: controllerEmail,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            label: Text("Email"),
                            errorText: emailError,
                            errorStyle: TextStyle(
                                color: Colors.red), // Show error message here
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Adjusted spacing
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        onChanged: (value) {
                          loginbloc.add(LoginOneCharactorPassowrdAccessEvent(
                              getcharPassword: value));
                        },
                        controller: controllerPassword,
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
                          errorText: passError,
                        ),
                        obscureText: _obsuretext,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetpasswordWidget(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Forgot Password?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: " →",
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 390,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          loginbloc.add(
                            LoginUsernameTextfeildEvent(
                                getusernamevalue: controllerEmail.text,
                                getpasswordvalue: controllerPassword.text),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'or signup with social account',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              loginbloc.add(GoogleButtonClickedEvent());
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              await sharedPreferences.setBool('islogin', true);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.red),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUSKL2F8gOghzLdVGApyBYLZ-ant8KEsNo2DZqLOtzW4ZZkjonnpnv8knoz1wog5cXiaU&usqp=CAU",
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
            ),
          ],
        ),
      ),
    );
  }
}
