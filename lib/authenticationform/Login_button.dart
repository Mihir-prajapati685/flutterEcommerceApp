import 'package:flutter/material.dart';

class Login_button extends StatelessWidget{
  bool isvisible = false;
  bool _obsuretext = true;
  final _formkey = GlobalKey<FormState>();
  var controller_username = TextEditingController();
  var controller_email = TextEditingController();
  var controller_password = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
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
                child:
                Padding(padding: EdgeInsets.only(left: 40,top: 180),
                  child:  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Create\n",
                          style: TextStyle(color: Colors.white70, fontSize: 40,fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "Account",
                          style: TextStyle(color: Colors.white70, fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),),


              ),
              Positioned(
                  left: 30,
                  top: 70,

                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white70,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        icon: Icon(Icons.arrow_back,size: 40,color: Colors.grey,)),
                  )
              ),
            ],
          ),
          Flexible(
            child: Form(
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
                            // setState(() {
                            //   _obsuretext = !_obsuretext;
                            //   isvisible = !isvisible;
                            // });
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
                    width: 390,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.deepOrangeAccent,Colors.white70]),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sign Up completed")),
                          );
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
                    ), )

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}