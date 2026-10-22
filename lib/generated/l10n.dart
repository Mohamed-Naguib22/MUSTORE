// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MUSTORE`
  String get appTitle {
    return Intl.message('MUSTORE', name: 'appTitle', desc: '', args: []);
  }

  /// `Retry`
  String get commonRetry {
    return Intl.message('Retry', name: 'commonRetry', desc: '', args: []);
  }

  /// `Something went wrong. Please try again.`
  String get commonSomethingWentWrong {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'commonSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get failureNetwork {
    return Intl.message(
      'No internet connection',
      name: 'failureNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired, please log in again`
  String get failureSessionExpired {
    return Intl.message(
      'Your session has expired, please log in again',
      name: 'failureSessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `The requested item was not found`
  String get failureNotFound {
    return Intl.message(
      'The requested item was not found',
      name: 'failureNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Server error, please try again later`
  String get failureServer {
    return Intl.message(
      'Server error, please try again later',
      name: 'failureServer',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again`
  String get failureGeneric {
    return Intl.message(
      'Something went wrong, please try again',
      name: 'failureGeneric',
      desc: '',
      args: [],
    );
  }

  /// `No saved data available`
  String get failureNoData {
    return Intl.message(
      'No saved data available',
      name: 'failureNoData',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save your settings, please try again`
  String get failureCache {
    return Intl.message(
      'Failed to save your settings, please try again',
      name: 'failureCache',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingsTheme {
    return Intl.message('Theme', name: 'settingsTheme', desc: '', args: []);
  }

  /// `Language`
  String get settingsLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get settingsAccount {
    return Intl.message('Account', name: 'settingsAccount', desc: '', args: []);
  }

  /// `System`
  String get themeSystem {
    return Intl.message('System', name: 'themeSystem', desc: '', args: []);
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `System`
  String get languageSystem {
    return Intl.message('System', name: 'languageSystem', desc: '', args: []);
  }

  /// `Home`
  String get navHome {
    return Intl.message('Home', name: 'navHome', desc: '', args: []);
  }

  /// `Cart`
  String get navCart {
    return Intl.message('Cart', name: 'navCart', desc: '', args: []);
  }

  /// `Categories`
  String get navCategories {
    return Intl.message(
      'Categories',
      name: 'navCategories',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get navAccount {
    return Intl.message('Account', name: 'navAccount', desc: '', args: []);
  }

  /// `Wishlist`
  String get navWishlist {
    return Intl.message('Wishlist', name: 'navWishlist', desc: '', args: []);
  }

  /// `Checkout`
  String get pageCheckout {
    return Intl.message('Checkout', name: 'pageCheckout', desc: '', args: []);
  }

  /// `Email`
  String get authEmail {
    return Intl.message('Email', name: 'authEmail', desc: '', args: []);
  }

  /// `name@example.com`
  String get authEmailHint {
    return Intl.message(
      'name@example.com',
      name: 'authEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPassword {
    return Intl.message('Password', name: 'authPassword', desc: '', args: []);
  }

  /// `Enter your password`
  String get authPasswordHint {
    return Intl.message(
      'Enter your password',
      name: 'authPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get authPasswordRequired {
    return Intl.message(
      'Password is required',
      name: 'authPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get authForgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'authForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get authLogIn {
    return Intl.message('Log in', name: 'authLogIn', desc: '', args: []);
  }

  /// `Sign up`
  String get authSignUp {
    return Intl.message('Sign up', name: 'authSignUp', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get authNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'authNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get authHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'authHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get authEmailRequired {
    return Intl.message(
      'Email is required',
      name: 'authEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get authEmailInvalid {
    return Intl.message(
      'Enter a valid email',
      name: 'authEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `At least {min} characters`
  String authPasswordTooShort(int min) {
    return Intl.message(
      'At least $min characters',
      name: 'authPasswordTooShort',
      desc: '',
      args: [min],
    );
  }

  /// `Log out`
  String get authLogOut {
    return Intl.message('Log out', name: 'authLogOut', desc: '', args: []);
  }

  /// `Enter the code`
  String get authOtpHint {
    return Intl.message(
      'Enter the code',
      name: 'authOtpHint',
      desc: '',
      args: [],
    );
  }

  /// `Verification code is required`
  String get authOtpRequired {
    return Intl.message(
      'Verification code is required',
      name: 'authOtpRequired',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get authOtp {
    return Intl.message(
      'Verification code',
      name: 'authOtp',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get signInRequiredTitle {
    return Intl.message(
      'Sign in to continue',
      name: 'signInRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `You need an account to access this page. Log in or create one to get started.`
  String get signInRequiredMessage {
    return Intl.message(
      'You need an account to access this page. Log in or create one to get started.',
      name: 'signInRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get signInRequiredAction {
    return Intl.message(
      'Log in',
      name: 'signInRequiredAction',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get signInRequiredSignUp {
    return Intl.message(
      'Create an account',
      name: 'signInRequiredSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Verify your email`
  String get verifyEmailTitle {
    return Intl.message(
      'Verify your email',
      name: 'verifyEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code we sent to {email}`
  String verifyEmailSubtitle(Object email) {
    return Intl.message(
      'Enter the code we sent to $email',
      name: 'verifyEmailSubtitle',
      desc: '',
      args: [email],
    );
  }

  /// `Verify`
  String get verifyEmailButton {
    return Intl.message(
      'Verify',
      name: 'verifyEmailButton',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get verifyEmailResend {
    return Intl.message(
      'Resend code',
      name: 'verifyEmailResend',
      desc: '',
      args: [],
    );
  }

  /// `A new code has been sent to your email`
  String get verifyEmailOtpResent {
    return Intl.message(
      'A new code has been sent to your email',
      name: 'verifyEmailOtpResent',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get loginTitle {
    return Intl.message('Welcome back', name: 'loginTitle', desc: '', args: []);
  }

  /// `Log in to continue shopping 🛍️`
  String get loginSubtitle {
    return Intl.message(
      'Log in to continue shopping 🛍️',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get registerTitle {
    return Intl.message(
      'Create account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Join {appName} and start shopping 🛒`
  String registerSubtitle(String appName) {
    return Intl.message(
      'Join $appName and start shopping 🛒',
      name: 'registerSubtitle',
      desc: '',
      args: [appName],
    );
  }

  /// `Create account`
  String get registerButton {
    return Intl.message(
      'Create account',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Account created. Please verify your email.`
  String get registerSuccess {
    return Intl.message(
      'Account created. Please verify your email.',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get fieldRequired {
    return Intl.message('Required', name: 'fieldRequired', desc: '', args: []);
  }

  /// `First name`
  String get authFirstName {
    return Intl.message(
      'First name',
      name: 'authFirstName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. John`
  String get authFirstNameHint {
    return Intl.message(
      'e.g. John',
      name: 'authFirstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get authLastName {
    return Intl.message('Last name', name: 'authLastName', desc: '', args: []);
  }

  /// `e.g. Doe`
  String get authLastNameHint {
    return Intl.message(
      'e.g. Doe',
      name: 'authLastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get authPhone {
    return Intl.message('Phone number', name: 'authPhone', desc: '', args: []);
  }

  /// `e.g. 01012345678`
  String get authPhoneHint {
    return Intl.message(
      'e.g. 01012345678',
      name: 'authPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get authPhoneRequired {
    return Intl.message(
      'Phone number is required',
      name: 'authPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get authGender {
    return Intl.message('Gender', name: 'authGender', desc: '', args: []);
  }

  /// `Select your gender`
  String get authGenderHint {
    return Intl.message(
      'Select your gender',
      name: 'authGenderHint',
      desc: '',
      args: [],
    );
  }

  /// `Select your gender`
  String get authGenderRequired {
    return Intl.message(
      'Select your gender',
      name: 'authGenderRequired',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get genderMale {
    return Intl.message('Male', name: 'genderMale', desc: '', args: []);
  }

  /// `Female`
  String get genderFemale {
    return Intl.message('Female', name: 'genderFemale', desc: '', args: []);
  }

  /// `Create a password`
  String get authCreatePasswordHint {
    return Intl.message(
      'Create a password',
      name: 'authCreatePasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get authConfirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'authConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get authConfirmPasswordHint {
    return Intl.message(
      'Re-enter your password',
      name: 'authConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get authPasswordsMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'authPasswordsMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully`
  String get loginSuccess {
    return Intl.message(
      'Logged in successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Email verified successfully`
  String get verifyEmailSuccess {
    return Intl.message(
      'Email verified successfully',
      name: 'verifyEmailSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logged out successfully`
  String get logoutSuccess {
    return Intl.message(
      'Logged out successfully',
      name: 'logoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgetPasswordTitle {
    return Intl.message(
      'Forgot password?',
      name: 'forgetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and we'll send you a verification code`
  String get forgetPasswordSubtitle {
    return Intl.message(
      'Enter your email and we\'ll send you a verification code',
      name: 'forgetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get forgetPasswordButton {
    return Intl.message(
      'Send code',
      name: 'forgetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `A verification code has been sent to your email`
  String get forgetPasswordSuccess {
    return Intl.message(
      'A verification code has been sent to your email',
      name: 'forgetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to {email} and choose a new password`
  String resetPasswordSubtitle(Object email) {
    return Intl.message(
      'Enter the code sent to $email and choose a new password',
      name: 'resetPasswordSubtitle',
      desc: '',
      args: [email],
    );
  }

  /// `Reset password`
  String get resetPasswordButton {
    return Intl.message(
      'Reset password',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully`
  String get resetPasswordSuccess {
    return Intl.message(
      'Password reset successfully',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get authNewPassword {
    return Intl.message(
      'New password',
      name: 'authNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get authNewPasswordHint {
    return Intl.message(
      'Enter your new password',
      name: 'authNewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Remember your password?`
  String get authRememberPassword {
    return Intl.message(
      'Remember your password?',
      name: 'authRememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get authOr {
    return Intl.message('or', name: 'authOr', desc: '', args: []);
  }

  /// `Continue with Google`
  String get authContinueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'authContinueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back 👋`
  String get homeWelcome {
    return Intl.message(
      'Welcome back 👋',
      name: 'homeWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Search products, categories...`
  String get homeSearchHint {
    return Intl.message(
      'Search products, categories...',
      name: 'homeSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Shop now`
  String get homeShopNow {
    return Intl.message('Shop now', name: 'homeShopNow', desc: '', args: []);
  }

  /// `See all`
  String get homeSeeAll {
    return Intl.message('See all', name: 'homeSeeAll', desc: '', args: []);
  }

  /// `Categories`
  String get homeCategories {
    return Intl.message(
      'Categories',
      name: 'homeCategories',
      desc: '',
      args: [],
    );
  }

  /// `Best sellers`
  String get homeBestSellers {
    return Intl.message(
      'Best sellers',
      name: 'homeBestSellers',
      desc: '',
      args: [],
    );
  }

  /// `New arrivals`
  String get homeNewArrivals {
    return Intl.message(
      'New arrivals',
      name: 'homeNewArrivals',
      desc: '',
      args: [],
    );
  }

  /// `On sale`
  String get homeOnSale {
    return Intl.message('On sale', name: 'homeOnSale', desc: '', args: []);
  }

  /// `Recommended for you`
  String get homeRecommended {
    return Intl.message(
      'Recommended for you',
      name: 'homeRecommended',
      desc: '',
      args: [],
    );
  }

  /// `Previously Ordered`
  String get homePreviouslyOrdered {
    return Intl.message(
      'Previously Ordered',
      name: 'homePreviouslyOrdered',
      desc: '',
      args: [],
    );
  }

  /// `Recently Viewed`
  String get homeRecentlyViewed {
    return Intl.message(
      'Recently Viewed',
      name: 'homeRecentlyViewed',
      desc: '',
      args: [],
    );
  }

  /// `Cairo, Egypt`
  String get homeLocationFallback {
    return Intl.message(
      'Cairo, Egypt',
      name: 'homeLocationFallback',
      desc: '',
      args: [],
    );
  }

  /// `Deliver to`
  String get homeDeliverTo {
    return Intl.message(
      'Deliver to',
      name: 'homeDeliverTo',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get accountTitle {
    return Intl.message('Account', name: 'accountTitle', desc: '', args: []);
  }

  /// `Edit profile`
  String get accountEditProfile {
    return Intl.message(
      'Edit profile',
      name: 'accountEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get accountContact {
    return Intl.message('Contact', name: 'accountContact', desc: '', args: []);
  }

  /// `Addresses`
  String get accountAddresses {
    return Intl.message(
      'Addresses',
      name: 'accountAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Phone numbers`
  String get accountPhoneNumbers {
    return Intl.message(
      'Phone numbers',
      name: 'accountPhoneNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get accountPreferences {
    return Intl.message(
      'Preferences',
      name: 'accountPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Account security`
  String get accountSecurity {
    return Intl.message(
      'Account security',
      name: 'accountSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get pageEditProfile {
    return Intl.message(
      'Your Profile',
      name: 'pageEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get profileFirstName {
    return Intl.message(
      'First name',
      name: 'profileFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get profileLastName {
    return Intl.message(
      'Last name',
      name: 'profileLastName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profileEmail {
    return Intl.message('Email', name: 'profileEmail', desc: '', args: []);
  }

  /// `Gender`
  String get profileGender {
    return Intl.message('Gender', name: 'profileGender', desc: '', args: []);
  }

  /// `Save changes`
  String get profileSave {
    return Intl.message(
      'Save changes',
      name: 'profileSave',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get profileFieldRequired {
    return Intl.message(
      'This field is required',
      name: 'profileFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated`
  String get profileUpdated {
    return Intl.message(
      'Profile updated',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Profile picture updated`
  String get profilePictureUpdated {
    return Intl.message(
      'Profile picture updated',
      name: 'profilePictureUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Choose from gallery`
  String get profileChooseGallery {
    return Intl.message(
      'Choose from gallery',
      name: 'profileChooseGallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get profileTakePhoto {
    return Intl.message(
      'Take a photo',
      name: 'profileTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Remove photo`
  String get profileRemovePhoto {
    return Intl.message(
      'Remove photo',
      name: 'profileRemovePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open the image picker`
  String get profilePickFailed {
    return Intl.message(
      'Couldn\'t open the image picker',
      name: 'profilePickFailed',
      desc: '',
      args: [],
    );
  }

  /// `Addresses`
  String get pageAddresses {
    return Intl.message('Addresses', name: 'pageAddresses', desc: '', args: []);
  }

  /// `Add address`
  String get addressesAddTitle {
    return Intl.message(
      'Add address',
      name: 'addressesAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit address`
  String get addressesEditTitle {
    return Intl.message(
      'Edit address',
      name: 'addressesEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete address?`
  String get addressesDeleteTitle {
    return Intl.message(
      'Delete address?',
      name: 'addressesDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `{street}, {city} will be removed from your saved addresses.`
  String addressesDeleteMessage(Object street, Object city) {
    return Intl.message(
      '$street, $city will be removed from your saved addresses.',
      name: 'addressesDeleteMessage',
      desc: '',
      args: [street, city],
    );
  }

  /// `Cancel`
  String get addressesCancel {
    return Intl.message('Cancel', name: 'addressesCancel', desc: '', args: []);
  }

  /// `Delete`
  String get addressesDelete {
    return Intl.message('Delete', name: 'addressesDelete', desc: '', args: []);
  }

  /// `Address added`
  String get addressesAdded {
    return Intl.message(
      'Address added',
      name: 'addressesAdded',
      desc: '',
      args: [],
    );
  }

  /// `Address updated`
  String get addressesUpdated {
    return Intl.message(
      'Address updated',
      name: 'addressesUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Default address changed`
  String get addressesDefaultChanged {
    return Intl.message(
      'Default address changed',
      name: 'addressesDefaultChanged',
      desc: '',
      args: [],
    );
  }

  /// `Address deleted`
  String get addressesDeleted {
    return Intl.message(
      'Address deleted',
      name: 'addressesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Could not load addresses`
  String get addressesLoadFailedTitle {
    return Intl.message(
      'Could not load addresses',
      name: 'addressesLoadFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get addressesGenericError {
    return Intl.message(
      'Something went wrong.',
      name: 'addressesGenericError',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get addressesRetry {
    return Intl.message('Retry', name: 'addressesRetry', desc: '', args: []);
  }

  /// `Add new address`
  String get addressesAddNew {
    return Intl.message(
      'Add new address',
      name: 'addressesAddNew',
      desc: '',
      args: [],
    );
  }

  /// `No addresses yet`
  String get addressesEmptyTitle {
    return Intl.message(
      'No addresses yet',
      name: 'addressesEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add a delivery address to speed up checkout.`
  String get addressesEmptyMessage {
    return Intl.message(
      'Add a delivery address to speed up checkout.',
      name: 'addressesEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Bldg {building}`
  String addressesBuilding(Object building) {
    return Intl.message(
      'Bldg $building',
      name: 'addressesBuilding',
      desc: '',
      args: [building],
    );
  }

  /// `Floor {floor}`
  String addressesFloor(Object floor) {
    return Intl.message(
      'Floor $floor',
      name: 'addressesFloor',
      desc: '',
      args: [floor],
    );
  }

  /// `Apt {apartment}`
  String addressesApartment(Object apartment) {
    return Intl.message(
      'Apt $apartment',
      name: 'addressesApartment',
      desc: '',
      args: [apartment],
    );
  }

  /// `Default`
  String get addressesDefaultBadge {
    return Intl.message(
      'Default',
      name: 'addressesDefaultBadge',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get addressesMenuEdit {
    return Intl.message('Edit', name: 'addressesMenuEdit', desc: '', args: []);
  }

  /// `Set as default`
  String get addressesMenuSetDefault {
    return Intl.message(
      'Set as default',
      name: 'addressesMenuSetDefault',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get addressesMenuDelete {
    return Intl.message(
      'Delete',
      name: 'addressesMenuDelete',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get addressesFieldStreet {
    return Intl.message(
      'Street',
      name: 'addressesFieldStreet',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 26th of July Corridor`
  String get addressesStreetHint {
    return Intl.message(
      'e.g. 26th of July Corridor',
      name: 'addressesStreetHint',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get addressesFieldCity {
    return Intl.message('City', name: 'addressesFieldCity', desc: '', args: []);
  }

  /// `Select city`
  String get addressesCityHint {
    return Intl.message(
      'Select city',
      name: 'addressesCityHint',
      desc: '',
      args: [],
    );
  }

  /// `Please select a city`
  String get addressesCityRequired {
    return Intl.message(
      'Please select a city',
      name: 'addressesCityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get addressesFieldBuilding {
    return Intl.message(
      'Building',
      name: 'addressesFieldBuilding',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get addressesFieldApartment {
    return Intl.message(
      'Apartment',
      name: 'addressesFieldApartment',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get addressesFieldFloor {
    return Intl.message(
      'Floor',
      name: 'addressesFieldFloor',
      desc: '',
      args: [],
    );
  }

  /// `Postal code`
  String get addressesFieldPostalCode {
    return Intl.message(
      'Postal code',
      name: 'addressesFieldPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Additional info`
  String get addressesFieldAdditionalInfo {
    return Intl.message(
      'Additional info',
      name: 'addressesFieldAdditionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Landmarks, delivery notes…`
  String get addressesAdditionalInfoHint {
    return Intl.message(
      'Landmarks, delivery notes…',
      name: 'addressesAdditionalInfoHint',
      desc: '',
      args: [],
    );
  }

  /// `Set as default address`
  String get addressesSetAsDefault {
    return Intl.message(
      'Set as default address',
      name: 'addressesSetAsDefault',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get addressesSaveChanges {
    return Intl.message(
      'Save changes',
      name: 'addressesSaveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Add address`
  String get addressesAddAction {
    return Intl.message(
      'Add address',
      name: 'addressesAddAction',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get addressesFieldRequired {
    return Intl.message(
      'This field is required',
      name: 'addressesFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get addressesFieldCountry {
    return Intl.message(
      'Country',
      name: 'addressesFieldCountry',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get addressesCountryHint {
    return Intl.message(
      'Select country',
      name: 'addressesCountryHint',
      desc: '',
      args: [],
    );
  }

  /// `Please select a country`
  String get addressesCountryRequired {
    return Intl.message(
      'Please select a country',
      name: 'addressesCountryRequired',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get addressesFieldGovernorate {
    return Intl.message(
      'Governorate',
      name: 'addressesFieldGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Select governorate`
  String get addressesGovernorateHint {
    return Intl.message(
      'Select governorate',
      name: 'addressesGovernorateHint',
      desc: '',
      args: [],
    );
  }

  /// `Please select a governorate`
  String get addressesGovernorateRequired {
    return Intl.message(
      'Please select a governorate',
      name: 'addressesGovernorateRequired',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 12`
  String get addressesBuildingHint {
    return Intl.message(
      'e.g. 12',
      name: 'addressesBuildingHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 5`
  String get addressesApartmentHint {
    return Intl.message(
      'e.g. 5',
      name: 'addressesApartmentHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 3`
  String get addressesFloorHint {
    return Intl.message(
      'e.g. 3',
      name: 'addressesFloorHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 11511`
  String get addressesPostalCodeHint {
    return Intl.message(
      'e.g. 11511',
      name: 'addressesPostalCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Season Sale`
  String get bannerSeasonSaleTitle {
    return Intl.message(
      'Season Sale',
      name: 'bannerSeasonSaleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Up to 50% off selected items`
  String get bannerSeasonSaleSubtitle {
    return Intl.message(
      'Up to 50% off selected items',
      name: 'bannerSeasonSaleSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `New Arrivals`
  String get bannerNewArrivalsTitle {
    return Intl.message(
      'New Arrivals',
      name: 'bannerNewArrivalsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fresh styles just landed`
  String get bannerNewArrivalsSubtitle {
    return Intl.message(
      'Fresh styles just landed',
      name: 'bannerNewArrivalsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Free Shipping`
  String get bannerFreeShippingTitle {
    return Intl.message(
      'Free Shipping',
      name: 'bannerFreeShippingTitle',
      desc: '',
      args: [],
    );
  }

  /// `On orders above 500 EGP`
  String get bannerFreeShippingSubtitle {
    return Intl.message(
      'On orders above 500 EGP',
      name: 'bannerFreeShippingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Fashion`
  String get categoryFashion {
    return Intl.message('Fashion', name: 'categoryFashion', desc: '', args: []);
  }

  /// `Phones`
  String get categoryPhones {
    return Intl.message('Phones', name: 'categoryPhones', desc: '', args: []);
  }

  /// `Laptops`
  String get categoryLaptops {
    return Intl.message('Laptops', name: 'categoryLaptops', desc: '', args: []);
  }

  /// `Home`
  String get categoryHome {
    return Intl.message('Home', name: 'categoryHome', desc: '', args: []);
  }

  /// `Beauty`
  String get categoryBeauty {
    return Intl.message('Beauty', name: 'categoryBeauty', desc: '', args: []);
  }

  /// `Sports`
  String get categorySports {
    return Intl.message('Sports', name: 'categorySports', desc: '', args: []);
  }

  /// `Books`
  String get categoryBooks {
    return Intl.message('Books', name: 'categoryBooks', desc: '', args: []);
  }

  /// `{price} EGP`
  String priceEgp(num price) {
    final NumberFormat priceNumberFormat = NumberFormat.decimalPattern(
      Intl.getCurrentLocale(),
    );
    final String priceString = priceNumberFormat.format(price);

    return Intl.message(
      '$priceString EGP',
      name: 'priceEgp',
      desc: '',
      args: [priceString],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
