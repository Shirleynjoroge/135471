import 'package:flutter/material.dart';
import 'package:aquaflow/core/app_export.dart';
import 'package:flutter/services.dart';

import '../../models/user.dart';

class CompanyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = ModalRoute.of(context)!.settings.arguments as UserModel?;
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed(
                          AppRoutes.createUser,
                          arguments: user, // Pass the user object as an argument
                        );
                      },
                      child: Card(
                        elevation: 6.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50, // Change the color as needed
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_add,
                                size: 100.0,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "Create User",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Add your onTap function for Requests here
                      },
                      child: Card(
                        elevation: 6.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50, // Change the color as needed
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.mail,
                                size: 100.0,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "Requests",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed(
                    AppRoutes.companyScreen,
                    arguments: user, // Pass the user object as an argument
                  );
                },
                child: Card(
                  elevation: 6.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100, // Change the color as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(
                            Icons.money,
                            size: 100.0,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "View Pending Bills",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Add your onTap function for Billing History here
                },
                child: Card(
                  elevation: 6.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100, // Change the color as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.history,
                            size: 100.0,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          "Billing History",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}


