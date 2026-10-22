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

  static String m0(apartment) => "Apt ${apartment}";

  static String m1(building) => "Bldg ${building}";

  static String m2(street, city) =>
      "${street}, ${city} will be removed from your saved addresses.";

  static String m3(floor) => "Floor ${floor}";

  static String m4(min) => "At least ${min} characters";

  static String m5(price) => "${price} EGP";

  static String m6(appName) => "Join ${appName} and start shopping 🛒";

  static String m7(email) =>
      "Enter the code sent to ${email} and choose a new password";

  static String m8(email) => "Enter the code we sent to ${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountAddresses": MessageLookupByLibrary.simpleMessage("Addresses"),
    "accountContact": MessageLookupByLibrary.simpleMessage("Contact"),
    "accountEditProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
    "accountPhoneNumbers": MessageLookupByLibrary.simpleMessage(
      "Phone numbers",
    ),
    "accountPreferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "accountSecurity": MessageLookupByLibrary.simpleMessage("Account security"),
    "accountTitle": MessageLookupByLibrary.simpleMessage("Account"),
    "addressesAddAction": MessageLookupByLibrary.simpleMessage("Add address"),
    "addressesAddNew": MessageLookupByLibrary.simpleMessage("Add new address"),
    "addressesAddTitle": MessageLookupByLibrary.simpleMessage("Add address"),
    "addressesAdded": MessageLookupByLibrary.simpleMessage("Address added"),
    "addressesAdditionalInfoHint": MessageLookupByLibrary.simpleMessage(
      "Landmarks, delivery notes…",
    ),
    "addressesApartment": m0,
    "addressesBuilding": m1,
    "addressesCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "addressesCityHint": MessageLookupByLibrary.simpleMessage("Select city"),
    "addressesCityRequired": MessageLookupByLibrary.simpleMessage(
      "Please select a city",
    ),
    "addressesCountryHint": MessageLookupByLibrary.simpleMessage(
      "Select country",
    ),
    "addressesCountryRequired": MessageLookupByLibrary.simpleMessage(
      "Please select a country",
    ),
    "addressesDefaultBadge": MessageLookupByLibrary.simpleMessage("Default"),
    "addressesDefaultChanged": MessageLookupByLibrary.simpleMessage(
      "Default address changed",
    ),
    "addressesDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "addressesDeleteMessage": m2,
    "addressesDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Delete address?",
    ),
    "addressesDeleted": MessageLookupByLibrary.simpleMessage("Address deleted"),
    "addressesEditTitle": MessageLookupByLibrary.simpleMessage("Edit address"),
    "addressesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Add a delivery address to speed up checkout.",
    ),
    "addressesEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No addresses yet",
    ),
    "addressesFieldAdditionalInfo": MessageLookupByLibrary.simpleMessage(
      "Additional info",
    ),
    "addressesFieldApartment": MessageLookupByLibrary.simpleMessage(
      "Apartment",
    ),
    "addressesFieldBuilding": MessageLookupByLibrary.simpleMessage("Building"),
    "addressesFieldCity": MessageLookupByLibrary.simpleMessage("City"),
    "addressesFieldCountry": MessageLookupByLibrary.simpleMessage("Country"),
    "addressesFieldFloor": MessageLookupByLibrary.simpleMessage("Floor"),
    "addressesFieldGovernorate": MessageLookupByLibrary.simpleMessage(
      "Governorate",
    ),
    "addressesFieldPostalCode": MessageLookupByLibrary.simpleMessage(
      "Postal code",
    ),
    "addressesFieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "addressesFieldStreet": MessageLookupByLibrary.simpleMessage("Street"),
    "addressesFloor": m3,
    "addressesGenericError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong.",
    ),
    "addressesGovernorateHint": MessageLookupByLibrary.simpleMessage(
      "Select governorate",
    ),
    "addressesGovernorateRequired": MessageLookupByLibrary.simpleMessage(
      "Please select a governorate",
    ),
    "addressesLoadFailedTitle": MessageLookupByLibrary.simpleMessage(
      "Could not load addresses",
    ),
    "addressesMenuDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "addressesMenuEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "addressesMenuSetDefault": MessageLookupByLibrary.simpleMessage(
      "Set as default",
    ),
    "addressesRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "addressesSaveChanges": MessageLookupByLibrary.simpleMessage(
      "Save changes",
    ),
    "addressesSetAsDefault": MessageLookupByLibrary.simpleMessage(
      "Set as default address",
    ),
    "addressesStreetHint": MessageLookupByLibrary.simpleMessage(
      "e.g. 26th of July Corridor",
    ),
    "addressesUpdated": MessageLookupByLibrary.simpleMessage("Address updated"),
    "appTitle": MessageLookupByLibrary.simpleMessage("MUSTORE"),
    "authConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "authConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Re-enter your password",
    ),
    "authContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "authCreatePasswordHint": MessageLookupByLibrary.simpleMessage(
      "Create a password",
    ),
    "authEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("name@example.com"),
    "authEmailInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email",
    ),
    "authEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "authFirstName": MessageLookupByLibrary.simpleMessage("First name"),
    "authFirstNameHint": MessageLookupByLibrary.simpleMessage("e.g. John"),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "authGender": MessageLookupByLibrary.simpleMessage("Gender"),
    "authGenderHint": MessageLookupByLibrary.simpleMessage(
      "Select your gender",
    ),
    "authGenderRequired": MessageLookupByLibrary.simpleMessage(
      "Select your gender",
    ),
    "authHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "authLastName": MessageLookupByLibrary.simpleMessage("Last name"),
    "authLastNameHint": MessageLookupByLibrary.simpleMessage("e.g. Doe"),
    "authLogIn": MessageLookupByLibrary.simpleMessage("Log in"),
    "authLogOut": MessageLookupByLibrary.simpleMessage("Log out"),
    "authNewPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "authNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter your new password",
    ),
    "authNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "authOr": MessageLookupByLibrary.simpleMessage("or"),
    "authOtp": MessageLookupByLibrary.simpleMessage("Verification code"),
    "authOtpHint": MessageLookupByLibrary.simpleMessage("Enter the code"),
    "authOtpRequired": MessageLookupByLibrary.simpleMessage(
      "Verification code is required",
    ),
    "authPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "authPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "authPasswordTooShort": m4,
    "authPasswordsMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "authPhone": MessageLookupByLibrary.simpleMessage("Phone number"),
    "authPhoneHint": MessageLookupByLibrary.simpleMessage("e.g. 01012345678"),
    "authPhoneRequired": MessageLookupByLibrary.simpleMessage(
      "Phone number is required",
    ),
    "authRememberPassword": MessageLookupByLibrary.simpleMessage(
      "Remember your password?",
    ),
    "authSignUp": MessageLookupByLibrary.simpleMessage("Sign up"),
    "bannerFreeShippingSubtitle": MessageLookupByLibrary.simpleMessage(
      "On orders above 500 EGP",
    ),
    "bannerFreeShippingTitle": MessageLookupByLibrary.simpleMessage(
      "Free Shipping",
    ),
    "bannerNewArrivalsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Fresh styles just landed",
    ),
    "bannerNewArrivalsTitle": MessageLookupByLibrary.simpleMessage(
      "New Arrivals",
    ),
    "bannerSeasonSaleSubtitle": MessageLookupByLibrary.simpleMessage(
      "Up to 50% off selected items",
    ),
    "bannerSeasonSaleTitle": MessageLookupByLibrary.simpleMessage(
      "Season Sale",
    ),
    "categoryBeauty": MessageLookupByLibrary.simpleMessage("Beauty"),
    "categoryBooks": MessageLookupByLibrary.simpleMessage("Books"),
    "categoryFashion": MessageLookupByLibrary.simpleMessage("Fashion"),
    "categoryHome": MessageLookupByLibrary.simpleMessage("Home"),
    "categoryLaptops": MessageLookupByLibrary.simpleMessage("Laptops"),
    "categoryPhones": MessageLookupByLibrary.simpleMessage("Phones"),
    "categorySports": MessageLookupByLibrary.simpleMessage("Sports"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "commonSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "failureCache": MessageLookupByLibrary.simpleMessage(
      "Failed to save your settings, please try again",
    ),
    "failureGeneric": MessageLookupByLibrary.simpleMessage(
      "Something went wrong, please try again",
    ),
    "failureNetwork": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "failureNoData": MessageLookupByLibrary.simpleMessage(
      "No saved data available",
    ),
    "failureNotFound": MessageLookupByLibrary.simpleMessage(
      "The requested item was not found",
    ),
    "failureServer": MessageLookupByLibrary.simpleMessage(
      "Server error, please try again later",
    ),
    "failureSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired, please log in again",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("Required"),
    "forgetPasswordButton": MessageLookupByLibrary.simpleMessage("Send code"),
    "forgetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your email and we\'ll send you a verification code",
    ),
    "forgetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "A verification code has been sent to your email",
    ),
    "forgetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "genderFemale": MessageLookupByLibrary.simpleMessage("Female"),
    "genderMale": MessageLookupByLibrary.simpleMessage("Male"),
    "homeBestSellers": MessageLookupByLibrary.simpleMessage("Best sellers"),
    "homeCategories": MessageLookupByLibrary.simpleMessage("Categories"),
    "homeDeliverTo": MessageLookupByLibrary.simpleMessage("Deliver to"),
    "homeLocationFallback": MessageLookupByLibrary.simpleMessage(
      "Cairo, Egypt",
    ),
    "homeNewArrivals": MessageLookupByLibrary.simpleMessage("New arrivals"),
    "homeOnSale": MessageLookupByLibrary.simpleMessage("On sale"),
    "homePreviouslyOrdered": MessageLookupByLibrary.simpleMessage(
      "Previously Ordered",
    ),
    "homeRecentlyViewed": MessageLookupByLibrary.simpleMessage(
      "Recently Viewed",
    ),
    "homeRecommended": MessageLookupByLibrary.simpleMessage(
      "Recommended for you",
    ),
    "homeSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search products, categories...",
    ),
    "homeSeeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "homeShopNow": MessageLookupByLibrary.simpleMessage("Shop now"),
    "homeWelcome": MessageLookupByLibrary.simpleMessage("Welcome back 👋"),
    "languageSystem": MessageLookupByLibrary.simpleMessage("System"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Log in to continue shopping 🛍️",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged in successfully",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "logoutSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged out successfully",
    ),
    "navAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "navCart": MessageLookupByLibrary.simpleMessage("Cart"),
    "navCategories": MessageLookupByLibrary.simpleMessage("Categories"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navWishlist": MessageLookupByLibrary.simpleMessage("Wishlist"),
    "pageAddresses": MessageLookupByLibrary.simpleMessage("Addresses"),
    "pageCheckout": MessageLookupByLibrary.simpleMessage("Checkout"),
    "pageEditProfile": MessageLookupByLibrary.simpleMessage("Your Profile"),
    "priceEgp": m5,
    "profileChooseGallery": MessageLookupByLibrary.simpleMessage(
      "Choose from gallery",
    ),
    "profileEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "profileFieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "profileFirstName": MessageLookupByLibrary.simpleMessage("First name"),
    "profileGender": MessageLookupByLibrary.simpleMessage("Gender"),
    "profileLastName": MessageLookupByLibrary.simpleMessage("Last name"),
    "profilePickFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t open the image picker",
    ),
    "profilePictureUpdated": MessageLookupByLibrary.simpleMessage(
      "Profile picture updated",
    ),
    "profileRemovePhoto": MessageLookupByLibrary.simpleMessage("Remove photo"),
    "profileSave": MessageLookupByLibrary.simpleMessage("Save changes"),
    "profileTakePhoto": MessageLookupByLibrary.simpleMessage("Take a photo"),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("Profile updated"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Create account"),
    "registerSubtitle": m6,
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Account created. Please verify your email.",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Create account"),
    "resetPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "resetPasswordSubtitle": m7,
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password reset successfully",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("Theme"),
    "signInRequiredAction": MessageLookupByLibrary.simpleMessage("Log in"),
    "signInRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "You need an account to access this page. Log in or create one to get started.",
    ),
    "signInRequiredSignUp": MessageLookupByLibrary.simpleMessage(
      "Create an account",
    ),
    "signInRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Sign in to continue",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "verifyEmailButton": MessageLookupByLibrary.simpleMessage("Verify"),
    "verifyEmailOtpResent": MessageLookupByLibrary.simpleMessage(
      "A new code has been sent to your email",
    ),
    "verifyEmailResend": MessageLookupByLibrary.simpleMessage("Resend code"),
    "verifyEmailSubtitle": m8,
    "verifyEmailSuccess": MessageLookupByLibrary.simpleMessage(
      "Email verified successfully",
    ),
    "verifyEmailTitle": MessageLookupByLibrary.simpleMessage(
      "Verify your email",
    ),
  };
}
