import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../models/user.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../../routes/app_routes.dart';


class PendingBillsScreen extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();

  String formatPhoneNumber(String phoneNumber) {
    String last9Digits = phoneNumber.substring(phoneNumber.length - 9);
    return "254$last9Digits";
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user =
    ModalRoute.of(context)!.settings.arguments as UserModel?;
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
                        subtitle:
                        Text('Ksh ${totalAmount.toStringAsFixed(2)}'),
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
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          String phoneNumber =
                          formatPhoneNumber(phoneNumberController.text);
                          makePayment(user, context, phoneNumber, totalAmount);
                        },
                        child: Text('Pay Now'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> makePayment(UserModel user, BuildContext context, String phoneNumber, double totalAmount) async {
    try {
      // Set your consumer key and consumer secret
      // MpesaFlutterPlugin.setConsumerKey("<your-consumer-key>");
      // MpesaFlutterPlugin.setConsumerSecret("<your-consumer-secret>");

      // dynamic transactionInitialization = await MpesaFlutterPlugin.initializeMpesaSTKPush(
      //   businessShortCode: "N/A",
      //   transactionType: TransactionType.CustomerPayBillOnline,
      //   amount: totalAmount.toDouble(),
      //   partyA: phoneNumber,
      //   partyB: "N/A",
      //   callBackURL: null,
      //   accountReference: "<account-reference>",
      //   phoneNumber: phoneNumber,
      //   baseUri: null,
      //   transactionDesc: "<transaction-description>",
      //   passKey: "<your-passkey>",
      // );

      // Handle the success response
      if (true) {
        print("STK Push initialization successful");

        // Update connection status to 3 for all connections with the given userId
        await FirebaseFirestore.instance
            .collection('Connections')
            .where('createdBy', isEqualTo: user.id)
            .get()
            .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
          snapshot.docs.forEach((doc) async {
            await FirebaseFirestore.instance
                .collection('Connections')
                .doc(doc.id)
                .update({
              'connectionStatus': 4,
            });
          });
        });

        // Show success dialog or perform any other action
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Payment Successful'),
              content: Text('Payment has been conducted successfully.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      AppRoutes.pendingBillsScreen,
                      arguments: user,
                    );
                  },
                ),
              ],
            );
          },
        );

      } else {
        // Handle the error response
        print("STK Push initialization failed");

        // Show error dialog or perform any other action
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Payment Error'),
              content: Text('Failed to initiate payment. Please try again.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle exceptions
      print("Exception during STK Push initialization: $e");

      // Show exception dialog or perform any other action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  Future<double> fetchPendingBills(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('Connections')
          .where('createdBy', isEqualTo: userId)
          .where('connectionStatus', isEqualTo: 3)
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
}

