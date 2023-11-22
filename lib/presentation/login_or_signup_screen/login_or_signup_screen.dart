import 'package:flutter/material.dart';
import 'package:aquaflow/core/app_export.dart';
import 'package:aquaflow/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:aquaflow/widgets/app_bar/custom_app_bar.dart';
import 'package:aquaflow/widgets/custom_elevated_button.dart';

class LoginOrSignupScreen extends StatelessWidget {
  const LoginOrSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray5001,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 25.v),
                child: Column(children: [
                  _buildPageHeader(context),
                  SizedBox(height: 31.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgLogoGray5001,
                      height: 105.v,
                      width: 117.h),
                  SizedBox(height: 33.v),
                  Text("Get in through", style: theme.textTheme.titleMedium),
                  SizedBox(height: 33.v),
                  CustomElevatedButton(
                      text: "Sign Up",
                      onPressed: () {
                        onTapSignUp(context);
                      }),
                  SizedBox(height: 14.v),
                  CustomElevatedButton(
                      text: "Login",
                      buttonStyle: CustomButtonStyles.fillDeepOrange,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallSecondaryContainer,
                      onPressed: () {
                        onTapLogin(context);
                      }),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.fromLTRB(49.h, 16.v, 302.h, 16.v),
            onTap: () {
              onTapArrowLeft(context);
            }));
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 208.h,
          child: Text("Aquaflow",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.displaySmall!.copyWith(height: 1.18))),
      SizedBox(height: 2.v),
      Container(
          width: 281.h,
          margin: EdgeInsets.only(right: 29.h),
          child: Text(
              "H20 to you",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall!.copyWith(height: 1.67)))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
