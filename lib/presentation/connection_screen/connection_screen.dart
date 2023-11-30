import 'package:aquaflow/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/connection.dart'; // Adjust the import path for your Connection model
import '../../widgets/custom_text_form_field.dart'; // Adjust the import path for your CustomTextFormField

class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final TextEditingController litresController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = ModalRoute.of(context)!.settings.arguments as UserModel?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Screen'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4.0,
                margin: EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Priced at Ksh 25.00 per litre',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // CustomTextFormField(
              //   controller: litresController,
              //   hintText: 'Litres',
              //   borderDecoration: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey),
              //   ),
              // ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                controller: locationController,
                hintText: 'Location',
                borderDecoration: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: () {
              //     calculatePrice();
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.blueGrey,
              //     onPrimary: Colors.white,
              //     padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              //   ),
              //   child: Text('Calculate Price', style: TextStyle(fontSize: 16.0)),
              // ),
              SizedBox(height: 16.0),
              // Card(
              //   elevation: 4.0,
              //   margin: EdgeInsets.only(bottom: 16.0),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Text(
              //       'Total Price: Ksh ${totalPrice.toStringAsFixed(2)}',
              //       style: TextStyle(
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  submitOrder(user?.id, user?.fullName);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade400,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                ),
                child: Text('Ask for a connection ?', style: TextStyle(fontSize: 16.0)),
              ),
            ],
          ),
        ),
    );
  }

  void calculatePrice() {
    double litres = double.tryParse(litresController.text) ?? 0.0;
    double pricePerLitre = 25.0;
    setState(() {
      totalPrice = litres * pricePerLitre;
    });
  }

  void submitOrder(String? userId, String? fullName) {
    try {
      String connectionName = generateConnectionName(fullName);
      int itemNumber = 1;
      String location = locationController.text;
      double amount = 0;//(double.tryParse(litresController.text)! * 25) ?? 0.0;

      Connection newConnection = Connection(
        id: '',
        connectionName: connectionName,
        location: location,
        amount: amount,
        itemNumber: itemNumber,
        connectionStatus: 1,
        createdBy: userId,
        createdDate: DateTime.now().toString(),
      );

      saveDataToFirebase(newConnection);
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error creating connection: $error'),
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

  String generateConnectionName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return '';
    }

    // Split the full name into an array of first and last names
    List<String> names = fullName.split(' ');
    String firstName = names[0];

    // Generate the connection name in the specified format
    String connectionName = 'Aquaflow_Connection-${firstName}-${DateTime.now().toString()}';
    return connectionName;
  }


  void saveDataToFirebase(Connection newConnection) async {
    try {
      // Assuming you have a Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document in the 'Connections' collection
      await firestore.collection('Connections').doc(newConnection.connectionName).set({
        'connectionName': newConnection.connectionName,
        'location': newConnection.location,
        'amount': newConnection.amount,
        'itemNumber': newConnection.itemNumber,
        'connectionStatus': newConnection.connectionStatus,
        'createdBy': newConnection.createdBy,
        'createdDate': newConnection.createdDate,
        'updatedBy': newConnection.updatedBy,
        'updatedDate': newConnection.updatedDate,
      });

      locationController.text = '';
      litresController.text = '';
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Connection requested successfully!'),
        ),
      );
    } catch (error) {
      // Handle errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error requesting connection'),
        ),
      );
    }
  }


}
