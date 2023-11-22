import 'package:flutter/material.dart';
import 'package:aquaflow/core/app_export.dart';
import 'package:flutter/services.dart';

import '../../models/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final UserModel? user = ModalRoute.of(context)!.settings.arguments as UserModel?;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Aquaflow',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.lightBlueAccent.shade100,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child:Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 30.h,
              top: 79.v,
              right: 30.h,
            ),
            child:Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 30.h,
                top: 79.v,
                right: 30.h,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the connection details page
                      Navigator.of(context).pushNamed(
                        AppRoutes.connectionScreen,
                        arguments: user, // Pass the user object as an argument
                      );
                    },
                    child: _buildConnection(context),
                  ),
                  SizedBox(height: 13.v),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the consumption page
                      Navigator.of(context).pushNamed(
                        AppRoutes.consumptionScreen,
                        arguments: user,
                      );
                    },
                    child: _buildConsumption(context),
                  ),
                  SizedBox(height: 13.v),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the pending bills page
                      Navigator.of(context).pushNamed(
                        AppRoutes.pendingBillsScreen,
                        arguments: user,
                      );
                    },
                    child: _buildPendingBills(context),
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildConnection(BuildContext context) {
    return Card(
        elevation: 6.0,
      child: Container(
        margin: EdgeInsets.only(left: 4.h),
        padding: EdgeInsets.symmetric(
          horizontal: 28.h,
          vertical: 16.v,
        ),
        decoration: AppDecoration.fillSecondaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgLocation,
              height: 100.v,
              width: 20.h,
              margin: EdgeInsets.symmetric(vertical: 4.v),
            ),
            Spacer(
              flex: 45,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text(
                "Ask for a connection",
                style: CustomTextStyles.titleMediumSecondaryContainer,
              ),
            ),
            Spacer(
              flex: 54,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgStroke1,
              height: 6.v,
              width: 5.h,
              radius: BorderRadius.circular(
                2.h,
              ),
              margin: EdgeInsets.only(
                top: 10.v,
                right: 5.h,
                bottom: 10.v,
              ),
            ),
          ],
        ),
      )
    );
  }

  /// Section Widget
  Widget _buildConsumption(BuildContext context) {
    return Card(elevation: 6.0,
      child: Container(
      margin: EdgeInsets.only(left: 4.h),
      padding: EdgeInsets.symmetric(
        horizontal: 28.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillDeepPurpleA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFile,
            height: 100.v,
            width: 17.h,
            margin: EdgeInsets.only(
              left: 3.h,
              top: 3.v,
              bottom: 3.v,
            ),
          ),
          Spacer(
            flex: 43,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              "View Consumption",
              style: CustomTextStyles.titleMediumDeeppurpleA400,
            ),
          ),
          Spacer(
            flex: 56,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgStroke1DeepPurpleA400,
            height: 6.v,
            width: 5.h,
            radius: BorderRadius.circular(
              2.h,
            ),
            margin: EdgeInsets.symmetric(vertical: 10.v),
          ),
        ],
      ),
    )
    );
  }

  /// Section Widget
  Widget _buildPendingBills(BuildContext context) {
    return Card(
        elevation: 6.0,
        child: Container(
      margin: EdgeInsets.only(left: 4.h),
      padding: EdgeInsets.symmetric(
        horizontal: 26.h,
        vertical: 15.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgInfo,
            height: 100.v,
            width: 19.h,
            margin: EdgeInsets.only(
              left: 3.h,
              top: 4.v,
              bottom: 4.v,
            ),
          ),
          Spacer(
            flex: 45,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(
              "Pending bills",
              style: CustomTextStyles.titleMediumPrimary,
            ),
          ),
          Spacer(
            flex: 54,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgStroke1Primary,
            height: 6.v,
            width: 5.h,
            radius: BorderRadius.circular(
              2.h,
            ),
            margin: EdgeInsets.symmetric(vertical: 11.v),
          ),
        ],
      ),
    )
    );
  }
}
