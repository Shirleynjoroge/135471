import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/connection.dart';
import '../../models/user.dart'; // Adjust the import path for your Connection model

class ConsumptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = ModalRoute.of(context)!.settings.arguments as UserModel?;
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumption Screen'),
      ),
      body: FutureBuilder(
        future: fetchConnections(user!.id), // Replace with your function to fetch data from Firebase
        builder: (context, AsyncSnapshot<List<Connection>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Connection> connections = snapshot.data ?? [];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    connections.length,
                        (index) => ConnectionCard(connection: connections[index]),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<Connection>> fetchConnections(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Connections')
          .where('createdBy', isEqualTo: userId)
          .get();

      List<Connection> connections = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()!;
        return Connection(
          id: doc.id,
          connectionName: data['connectionName'] ?? '',
          location: data['location'] ?? '',
          amount: (data['amount'] ?? 0.0).toDouble(),
          itemNumber: data['itemNumber'] ?? 0,
          connectionStatus: data['connectionStatus'] ?? 0,
          createdBy: data['createdBy'] ?? '',
          createdDate: data['createdDate'] ?? '',
          updatedBy: data['updatedBy'] ?? '',
          updatedDate: data['updatedDate'] ?? '',
        );
      }).toList();

      return connections;
    } catch (error) {
      throw error;
    }
  }

}

class ConnectionCard extends StatelessWidget {
  final Connection connection;

  ConnectionCard({required this.connection});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(
          Icons.local_drink,
          color: Colors.lightBlue, // Set the color to blue
        ), // Replace with an appropriate water-related icon
        title: Text(connection.connectionName),
        //subtitle: Text('Amount: Ksh ${connection.amount.toStringAsFixed(2)}'),
        subtitle: Text(connection.connectionStatus == 1 ? 'Pending' : ''),

      ),
    );
  }
}
