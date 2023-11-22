import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../models/connection.dart';
import '../../models/user.dart';

class PendingBillsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = ModalRoute.of(context)!.settings.arguments as UserModel?;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Bills'),
      ),
      body: FutureBuilder(
        future: fetchPendingBills(user!.id),
        builder: (context, AsyncSnapshot<double> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            double totalAmount = snapshot.data ?? 0.0;

            return Center(
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.fullName ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.monetization_on,
                          color: Colors.lightGreen.shade900,
                        ),
                        title: Text('Total Pending Amount'),
                        subtitle: Text('Ksh ${totalAmount.toStringAsFixed(2)}'),
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Today\'s Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle "Pay Now" button press
        },
        icon: Icon(Icons.payment),
        label: Text('Pay Now'),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<double> fetchPendingBills(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Connections')
          .where('createdBy', isEqualTo: userId)
          .get();

      double totalAmount = 0.0;

      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data()!;
        totalAmount += (data['amount'] ?? 0.0).toDouble();
      });

      return totalAmount;
    } catch (error) {
      throw error;
    }
  }

  void payNow(String userId, double totalAmount) {
    // Add your logic for handling payment
    // This could include integrating with a payment gateway, updating payment status in Firestore, etc.
    // Show success or failure dialog based on the result
    // ...
  }
}
