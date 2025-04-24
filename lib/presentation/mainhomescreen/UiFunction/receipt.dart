import 'package:ecommerce_app/presentation/mainhomescreen/Main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BLoC package

// Dummy BLoC event and state for example
class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  // Method to reset state or perform actions on home navigation
  void goToHome() {
    emit(0); // Reset or perform necessary actions
  }
}

class ReceiptPage extends StatelessWidget {
  final String orderId = 'ORD123456';
  final String customerName = 'John Doe';
  final String transactionId = 'txn_1234567890';
  final double totalAmount = 200.0;

  final List<Map<String, dynamic>> items = [
    {'name': 'Product 1', 'quantity': 2, 'price': 50.0},
    {'name': 'Product 2', 'quantity': 1, 'price': 100.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Receipt Header
            Center(
              child: Text(
                'Receipt',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(height: 20),

            // Order Details
            Text(
              'Order ID: $orderId',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Customer: $customerName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Transaction ID: $transactionId',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Order Items Table
            Text(
              'Items Purchased:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Item',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Price',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                ]),
                for (var item in items)
                  TableRow(
                    children: [
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item['name']),
                      )),
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item['quantity'].toString()),
                      )),
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\$${item['price']}'),
                      )),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),

            // Total Amount
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 20),

            // Success Message
            Center(
              child: Text(
                'Payment Successful!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(height: 20),

            // Footer with options
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<NavigationCubit>().goToHome();
                  // Clear navigation stack and go to home
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MainScreenState()), // Replace with your actual HomePage widget
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
                },
                child: Text('Back to Home'),
                style: ElevatedButton.styleFrom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

void main() {
  runApp(
    BlocProvider(
      create: (_) => NavigationCubit(), // Provide the BLoC to the entire app
      child: MaterialApp(
        home: ReceiptPage(),
      ),
    ),
  );
}
