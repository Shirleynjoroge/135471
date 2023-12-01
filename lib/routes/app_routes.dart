import 'package:flutter/material.dart';
import 'package:aquaflow/presentation/splash_screen/splash_screen.dart';
import 'package:aquaflow/presentation/login_or_signup_screen/login_or_signup_screen.dart';
import 'package:aquaflow/presentation/signup_screen/signup_screen.dart';
import 'package:aquaflow/presentation/login_screen/login_screen.dart';
import 'package:aquaflow/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:aquaflow/presentation/home_screen/home_screen.dart';
import 'package:aquaflow/presentation/work_today_screen/work_today_screen.dart';
import 'package:aquaflow/presentation/wish_list_screen/wish_list_screen.dart';
import 'package:aquaflow/presentation/settings_screen/settings_screen.dart';
import 'package:aquaflow/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:aquaflow/presentation/company_screen/company_screen.dart';
import 'package:aquaflow/presentation/create_user/create_user.dart';
import 'package:aquaflow/presentation/company_screen/company_screen.dart';
import 'package:aquaflow/presentation/consumption_screen/consumption_screen.dart';
import 'package:aquaflow/presentation/connection_screen/connection_screen.dart';
import 'package:aquaflow/presentation/pending_bills_screen/pending_bills_screen.dart';
import 'package:aquaflow/presentation/all_pending_bills/all_pending_bills.dart';
import 'package:aquaflow/presentation/requests/requests.dart';
import 'package:aquaflow/presentation/billing_history/billing_history.dart';
import 'package:aquaflow/presentation/requests/requests.dart';
import 'package:aquaflow/presentation/pending_requests/pending_requests.dart';
import 'package:aquaflow/presentation/bill_clients/bill_clients.dart';
import 'package:aquaflow/presentation/reports/reports.dart';



class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginOrSignupScreen = '/login_or_signup_screen';

  static const String signupScreen = '/signup_screen';

  static const String loginScreen = '/login_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String homeScreen = '/home_screen';

  static const String workTodayScreen = '/work_today_screen';

  static const String wishListScreen = '/wish_list_screen';

  static const String settingsScreen = '/settings_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String companyScreen = '/company_screen';

  static const String createUser = '/create_user';

  static const String connectionScreen = '/connection_screen';

  static const String consumptionScreen = '/consumption_screen';

  static const String pendingBillsScreen = '/pending_bills_screen';

  static const String allpendingBillsScreen = '/allpending_bills_screen';

  static const String requests = '/requests';

  static const String billingHistory = '/billing_history';

  static const String pendingRequestsScreen = '/pending_requests';

  static const String billClientsScreen = '/bill_clients';
  static const String reportsScreen = '/reports';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    loginOrSignupScreen: (context) => LoginOrSignupScreen(),
    signupScreen: (context) => SignupScreen(),
    loginScreen: (context) => LoginScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    homeScreen: (context) => HomeScreen(),
    workTodayScreen: (context) => WorkTodayScreen(),
    wishListScreen: (context) => WishListScreen(),
    settingsScreen: (context) => SettingsScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    companyScreen: (context) => CompanyScreen(),
    createUser: (context) => CreateUser(),
    connectionScreen: (context) => ConnectionScreen(),
    consumptionScreen: (context) => ConsumptionScreen(),
    pendingBillsScreen: (context) => PendingBillsScreen(),
    allpendingBillsScreen: (context) => AllPendingBillsScreen(),
    requests: (context) => RequestsScreen(),
    billingHistory: (context) => BillingHistory(),
    pendingRequestsScreen: (context) => PendingRequestsScreen(),
    billClientsScreen: (context) => BillClientsScreen(),
    reportsScreen: (context) => ReportsScreen(),
  };
}
