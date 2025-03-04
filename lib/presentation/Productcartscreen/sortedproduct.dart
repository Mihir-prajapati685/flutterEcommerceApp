import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Sort by',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: const Text("Popular"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Newest"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Customer review"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Price: lowest to high"),
                  tileColor: Colors.red, // Highlighted option
                  textColor: Colors.white,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Price: highest to low"),
                  onTap: () {},
                ),
              ],
            ),
          ));
    },
  );
}
