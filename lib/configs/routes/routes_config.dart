import 'package:academix/configs/layout/responsive_layout.dart';
import 'package:academix/configs/routes/error_page/page_not_found.dart';
import 'package:academix/constants/routes_path.dart';
import 'package:academix/features/authentication/forgot_password/view/desktop/desktop_forgot_password.dart';
import 'package:academix/features/authentication/forgot_password/view/phone/phone_forgot_password.dart';
import 'package:academix/features/authentication/forgot_password/view/tablet/tablet_forgot_password.dart';
import 'package:academix/features/authentication/sign_in/view/desktop/sign_in_desktop_view.dart';
import 'package:academix/features/authentication/sign_in/view/phone/sign_in_phone_view.dart';
import 'package:academix/features/authentication/sign_in/view/tablet/sign_in_tablet_view.dart';
import 'package:academix/features/authentication/sign_up/view/desktop/desktop_sign_up_view.dart';
import 'package:academix/features/authentication/sign_up/view/phone/phone_sign_up_view.dart';
import 'package:academix/features/authentication/sign_up/view/tablet/tablet_sign_up_view.dart';
import 'package:academix/features/view_wrapper/desktop/desktop_wrapper.dart';
import 'package:academix/features/view_wrapper/phone/phone_wrapper.dart';
import 'package:academix/features/view_wrapper/tablet/tablet_wrapper.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Defines the router configuration for the Academix application using the GoRouter package.
///
/// The `academixRouter` instance of the [GoRouter] class defines the routes and their corresponding builders for different screens in the application.
/// The router is responsible for handling navigation and rendering the appropriate screen based on the current route.
GoRouter academixRouter = GoRouter(
  errorBuilder: (context, state) => const PageNotFound(),
  routes: [
    // Home route
    GoRoute(
      path: RoutesPath.home,
      builder: (context, state) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingWidget(); // loading
          } else if (snapshot.hasError) {
            return _buildErrorMessageWidget(); // restart the app message
          } else if (snapshot.hasData) {
            return const ResponsiveLayout(
              phone: PhoneWrapper(),
              tablet: TabletWrapper(),
              desktop: DesktopWrapper(),
            ); // home screen
          } else {
            return const ResponsiveLayout(
              phone: PhoneSignInView(),
              tablet: TabletSignInView(),
              desktop: DesktopSignInView(),
            );
          }
        },
      ),
    ),
    // Sign-up route
    GoRoute(
      path: RoutesPath.signUp,
      builder: (context, state) => const ResponsiveLayout(
        phone: PhoneSignUpView(),
        tablet: TabletSignUpView(),
        desktop: DesktopSignUpView(),
      ),
    ),
    // Forgot-password route
    GoRoute(
      path: RoutesPath.forgotPassword,
      builder: (context, state) => const ResponsiveLayout(
        phone: PhoneForgotPassword(),
        tablet: TabletForgotPassword(),
        desktop: DesktopForgotPassword(),
      ),
    ),
  ],
);

Widget _buildLoadingWidget() {
  return Container(); // Replace with your loading widget
}

Widget _buildErrorMessageWidget() {
  return Container(); // Replace with your error message widget
}
