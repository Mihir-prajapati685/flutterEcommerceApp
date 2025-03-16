import 'package:flutter/material.dart';

class EditButtonpage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Add delivery address"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField("Full Name*", nameController),
                buildTextField("Phone Number*", phoneController,
                    keyboardType: TextInputType.phone),
                buildTextField("Pincode*", pincodeController,
                    keyboardType: TextInputType.number),
                buildTextField("State*", stateController),
                buildTextField("City*", cityController),
                buildTextField("House No., Building Name*", houseController),
                buildTextField("Road name, Area, Colony", roadController),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Address Saved Successfully!")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Save Address",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "This field is required";
        //   }
        //   return null;
        // },
      ),
    );
  }
}
