// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(min) => "At least ${min} characters";

  static String m1(price) => "${price} EGP";

  static String m2(appName) => "Join ${appName} and start shopping";

  static String m3(email) =>
      "Enter the code sent to ${email} and choose a new password";

  static String m4(email) => "Enter the code we sent to ${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("MUSTORE"),
        "authConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "authConfirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Re-enter your password"),
        "authContinueWithGoogle":
            MessageLookupByLibrary.simpleMessage("Continue with Google"),
        "authCreatePasswordHint":
            MessageLookupByLibrary.simpleMessage("Create a password"),
        "authEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "authEmailHint":
            MessageLookupByLibrary.simpleMessage("name@example.com"),
        "authEmailInvalid":
            MessageLookupByLibrary.simpleMessage("Enter a valid email"),
        "authEmailRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "authFirstName": MessageLookupByLibrary.simpleMessage("First name"),
        "authFirstNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your first name"),
        "authForgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "authGender": MessageLookupByLibrary.simpleMessage("Gender"),
        "authGenderHint":
            MessageLookupByLibrary.simpleMessage("Select your gender"),
        "authGenderRequired":
            MessageLookupByLibrary.simpleMessage("Select your gender"),
        "authHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "authLastName": MessageLookupByLibrary.simpleMessage("Last name"),
        "authLastNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your last name"),
        "authLogIn": MessageLookupByLibrary.simpleMessage("Log in"),
        "authLogOut": MessageLookupByLibrary.simpleMessage("Log out"),
        "authNewPassword": MessageLookupByLibrary.simpleMessage("New password"),
        "authNewPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter your new password"),
        "authNoAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "authOr": MessageLookupByLibrary.simpleMessage("or"),
        "authOtp": MessageLookupByLibrary.simpleMessage("Verification code"),
        "authOtpHint": MessageLookupByLibrary.simpleMessage("Enter the code"),
        "authOtpRequired": MessageLookupByLibrary.simpleMessage(
            "Verification code is required"),
        "authPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "authPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "authPasswordRequired":
            MessageLookupByLibrary.simpleMessage("Password is required"),
        "authPasswordTooShort": m0,
        "authPasswordsMismatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "authPhone": MessageLookupByLibrary.simpleMessage("Phone number"),
        "authPhoneHint":
            MessageLookupByLibrary.simpleMessage("e.g. 01012345678"),
        "authPhoneRequired":
            MessageLookupByLibrary.simpleMessage("Phone number is required"),
        "authRememberPassword":
            MessageLookupByLibrary.simpleMessage("Remember your password?"),
        "authSignUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "bannerFreeShippingSubtitle":
            MessageLookupByLibrary.simpleMessage("On orders above 500 EGP"),
        "bannerFreeShippingTitle":
            MessageLookupByLibrary.simpleMessage("Free Shipping"),
        "bannerNewArrivalsSubtitle":
            MessageLookupByLibrary.simpleMessage("Fresh styles just landed"),
        "bannerNewArrivalsTitle":
            MessageLookupByLibrary.simpleMessage("New Arrivals"),
        "bannerSeasonSaleSubtitle": MessageLookupByLibrary.simpleMessage(
            "Up to 50% off selected items"),
        "bannerSeasonSaleTitle":
            MessageLookupByLibrary.simpleMessage("Season Sale"),
        "categoryBeauty": MessageLookupByLibrary.simpleMessage("Beauty"),
        "categoryBooks": MessageLookupByLibrary.simpleMessage("Books"),
        "categoryFashion": MessageLookupByLibrary.simpleMessage("Fashion"),
        "categoryHome": MessageLookupByLibrary.simpleMessage("Home"),
        "categoryLaptops": MessageLookupByLibrary.simpleMessage("Laptops"),
        "categoryPhones": MessageLookupByLibrary.simpleMessage("Phones"),
        "categorySports": MessageLookupByLibrary.simpleMessage("Sports"),
        "failureCache": MessageLookupByLibrary.simpleMessage(
            "Failed to save your settings, please try again"),
        "failureGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong, please try again"),
        "failureNetwork":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "failureNoData":
            MessageLookupByLibrary.simpleMessage("No saved data available"),
        "failureNotFound": MessageLookupByLibrary.simpleMessage(
            "The requested item was not found"),
        "failureServer": MessageLookupByLibrary.simpleMessage(
            "Server error, please try again later"),
        "failureSessionExpired": MessageLookupByLibrary.simpleMessage(
            "Your session has expired, please log in again"),
        "fieldRequired": MessageLookupByLibrary.simpleMessage("Required"),
        "forgetPasswordButton":
            MessageLookupByLibrary.simpleMessage("Send code"),
        "forgetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
            "Enter your email and we\'ll send you a verification code"),
        "forgetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
            "A verification code has been sent to your email"),
        "forgetPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "genderFemale": MessageLookupByLibrary.simpleMessage("Female"),
        "genderMale": MessageLookupByLibrary.simpleMessage("Male"),
        "homeBestSellers": MessageLookupByLibrary.simpleMessage("Best sellers"),
        "homeCategories": MessageLookupByLibrary.simpleMessage("Categories"),
        "homeNewArrivals": MessageLookupByLibrary.simpleMessage("New arrivals"),
        "homeSearchHint": MessageLookupByLibrary.simpleMessage(
            "Search products, categories..."),
        "homeSeeAll": MessageLookupByLibrary.simpleMessage("See all"),
        "homeShopNow": MessageLookupByLibrary.simpleMessage("Shop now"),
        "homeWelcome": MessageLookupByLibrary.simpleMessage("Welcome back 👋"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("System"),
        "loginSubtitle":
            MessageLookupByLibrary.simpleMessage("Log in to continue shopping"),
        "loginSuccess":
            MessageLookupByLibrary.simpleMessage("Logged in successfully"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Welcome back"),
        "logoutSuccess":
            MessageLookupByLibrary.simpleMessage("Logged out successfully"),
        "navAccount": MessageLookupByLibrary.simpleMessage("Account"),
        "navCart": MessageLookupByLibrary.simpleMessage("Cart"),
        "navCategories": MessageLookupByLibrary.simpleMessage("Categories"),
        "navHome": MessageLookupByLibrary.simpleMessage("Home"),
        "pageCheckout": MessageLookupByLibrary.simpleMessage("Checkout"),
        "pageEditProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
        "priceEgp": m1,
        "registerButton":
            MessageLookupByLibrary.simpleMessage("Create account"),
        "registerSubtitle": m2,
        "registerSuccess": MessageLookupByLibrary.simpleMessage(
            "Account created. Please verify your email."),
        "registerTitle": MessageLookupByLibrary.simpleMessage("Create account"),
        "resetPasswordButton":
            MessageLookupByLibrary.simpleMessage("Reset password"),
        "resetPasswordSubtitle": m3,
        "resetPasswordSuccess":
            MessageLookupByLibrary.simpleMessage("Password reset successfully"),
        "resetPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Reset password"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
        "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
        "settingsTheme": MessageLookupByLibrary.simpleMessage("Theme"),
        "signInRequiredAction": MessageLookupByLibrary.simpleMessage("Log in"),
        "signInRequiredMessage": MessageLookupByLibrary.simpleMessage(
            "You need an account to access this page. Log in or create one to get started."),
        "signInRequiredSignUp":
            MessageLookupByLibrary.simpleMessage("Create an account"),
        "signInRequiredTitle":
            MessageLookupByLibrary.simpleMessage("Sign in to continue"),
        "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
        "verifyEmailButton": MessageLookupByLibrary.simpleMessage("Verify"),
        "verifyEmailOtpResent": MessageLookupByLibrary.simpleMessage(
            "A new code has been sent to your email"),
        "verifyEmailResend":
            MessageLookupByLibrary.simpleMessage("Resend code"),
        "verifyEmailSubtitle": m4,
        "verifyEmailSuccess":
            MessageLookupByLibrary.simpleMessage("Email verified successfully"),
        "verifyEmailTitle":
            MessageLookupByLibrary.simpleMessage("Verify your email")
      };
}
