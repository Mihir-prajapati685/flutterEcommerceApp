import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Top product',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          height: 500,
          width: 700,
          child:
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
           child: GridView.count(crossAxisCount: 2,
             mainAxisSpacing: 10,
             crossAxisSpacing: 10,
             childAspectRatio: 0.5,
             children: [
               Container(
                 height:600,
                 width: 400,
                 decoration: BoxDecoration(
                   color: Colors.white70,
                   border: Border.all(
                     color: Colors.white70,
                     width:2,
                   ),
                   borderRadius: BorderRadius.circular(25),
                 ),
                 child:Column(
                   children: [
                     Center(
                       child: Container(
                         margin: EdgeInsets.all(10),
                         height: 300,
                         child:ClipRRect(
                           borderRadius: BorderRadius.circular(20),
                           child:Container(
                             width:370,
                             child: Image.network("https://i.pinimg.com/236x/b0/9d/ce/b09dce1fbeeec696d0c581cf4cff3163.jpg",fit: BoxFit.cover,),
                           ),
                         ),
                       ),
                     ),
                     Container(
                       margin: EdgeInsets.only(top:10,left: 15),
                       child: Text('Regular Fit Printed Polo T-shirt With Vent...',
                         style: TextStyle(color: Colors.grey[800],fontSize: 17,fontWeight: FontWeight.w500),),
                     )
                   ],
                 ),
               ),
             ],
           ) ,
    )

        ),
      ],
    );
  }
}
