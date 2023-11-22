import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';
import '../../routes/app_routes.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';


class CreateUser extends StatelessWidget {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> saveUserData(BuildContext context, UserModel user) async {
    try {
      String formattedDate = DateTime.now().toString().replaceAll(" ", "_").replaceAll(":", "_").replaceAll(".", "_").replaceAll("-", "_");
      String generatedID = user.fullName.split(" ")[0] + "-" + formattedDate;
      user.id = generatedID;
      user.role = 1; //
      user.createdBy = '2'; // Assuming default creator is 1
      user.createdDate = DateTime.now().toString();

      await FirebaseFirestore.instance.collection('Users').doc(user.id).set({
        'fullName': user.fullName,
        'userName': user.userName,
        'password': user.password,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'location': user.location,
        'role': user.role,
        'createdBy': user.createdBy,
        'createdDate': user.createdDate,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('User Created'),
            content: Text('User has been created successfully.'),
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

    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not create the user.'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a user'),
          backgroundColor: Colors.blue.shade50,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0),
                  CustomTextFormField(
                    controller: fullNameController,
                    hintText: "Full Name",
                    borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL14,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL14,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL14,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    hintText: "Phone Number",
                    borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL14,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: locationController,
                    hintText: "Location",
                    borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL14,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50.0),
                  CustomElevatedButton(
                    text: "Create",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        UserModel user = UserModel(
                          id: '', // ID will be generated later
                          fullName: fullNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phoneNumber: phoneNumberController.text,
                          location: locationController.text,
                          role: 0, // Default role, change as needed
                          createdBy: '1', // Default creator, change as needed
                          createdDate: DateTime.now().toString(),
                        );
                        saveUserData(context, user);
                      }
                    },
                    buttonStyle: CustomButtonStyles.fillDeepOrange,
                    buttonTextStyle: CustomTextStyles.titleSmallSecondaryContainer,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
