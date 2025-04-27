import 'package:ecommerce_app/presentation/mainhomescreen/Main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Import BLoC package

// Dummy BLoC event and state for example
class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  // Method to reset state or perform actions on home navigation
  void goToHome() {
    emit(0); // Reset or perform necessary actions
  }
}

class ReceiptPage extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String transactionId;
  final double totalAmount;
  final List<Map<String, dynamic>> items;
  const ReceiptPage({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.transactionId,
    required this.totalAmount,
    required this.items,
  }) : super(key: key);

  @override
  Future<void> generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text('Receipt',
                  style: pw.TextStyle(
                      fontSize: 32, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Order ID: $orderId'),
            pw.Text('Customer: $customerName'),
            pw.Text('Transaction ID: $transactionId'),
            pw.SizedBox(height: 20),
            pw.Text('Items Purchased:',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Item',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Quantity',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Price',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ],
                ),
                for (var item in items)
                  pw.TableRow(
                    children: [
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(item['name'])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(item['quantity'].toString())),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('\$${item['price']}')),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text('Total: \$${totalAmount.toStringAsFixed(2)}',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Center(
                child: pw.Text('Payment Successful!',
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold))),
          ],
        ),
      ),
    );

    try {
      // Step 1: Get the downloads directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/receipt.pdf"; // Filename

      // Step 2: Save the file
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      print('PDF Saved: $filePath');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded successfully! 🎉'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Optional: Show snackbar or toast
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Receipt downloaded successfully!')),
      // );
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.download), // Download icon
            onPressed: () {
              generatePdf(context); // Call the PDF generate function
            },
          ),
        ],
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
        home: HomePage(),
      ),
    ),
  );
}
