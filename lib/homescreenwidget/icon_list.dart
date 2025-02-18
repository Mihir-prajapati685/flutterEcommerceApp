
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class icon_list extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(padding:EdgeInsets.symmetric(vertical: 30,horizontal: 20),
      child:Container(
         width: 420,
        child:  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 232, 232), // Soft grey border color
                    width: 2, // Border width
                  ),
                ),
                  child:Center(
                    child:FaIcon(FontAwesomeIcons.shirt,color: Colors.brown,),
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 232, 232), // Soft grey border color
                    width: 2, // Border width
                  ),
                ),
                child:Center(
                  child:FaIcon(FontAwesomeIcons.shirt,color: Colors.brown,),
                )

              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 232, 232), // Soft grey border color
                    width: 2, // Border width
                  ),
                ),
                  child:Center(
                    child:FaIcon(FontAwesomeIcons.shirt,color: Colors.brown,),
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 232, 232), // Soft grey border color
                    width: 2, // Border width
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 232, 232), // Soft grey border color
                    width: 2, // Border width
                  ),
                ),
              ),
            ],
          ),),
      )

      );


  }
}
