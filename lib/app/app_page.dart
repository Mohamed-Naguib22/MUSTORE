import 'package:flutter/material.dart';
import 'package:mustore/core/utils/enums/access_level.dart';
import 'package:mustore/app/router/screens/splash_screen.dart';
import 'package:mustore/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:mustore/features/auth/presentation/screens/login_screen.dart';
import 'package:mustore/features/auth/presentation/screens/register_screen.dart';
import 'package:mustore/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:mustore/features/auth/presentation/screens/sign_in_required_screen.dart';
import 'package:mustore/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:mustore/features/catalog/presentation/screens/categories_screen.dart';
import 'package:mustore/features/home/presentation/screens/home_screen.dart';
import 'package:mustore/features/profile/presentation/screens/account_screen.dart';
import 'package:mustore/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mustore/features/settings/presentation/screens/settings_screen.dart';
import 'package:mustore/features/shopping/presentation/screens/cart_screen.dart';
import 'package:mustore/features/shopping/presentation/screens/checkout_screen.dart';
import 'package:mustore/generated/l10n.dart';

enum AppBarMode { standard, none }

enum AppPage {
  splash('/splash', AccessLevel.public, SplashScreen.new, appBar: AppBarMode.none),

  login('/login', AccessLevel.guestOnly, LoginScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  register('/register', AccessLevel.guestOnly, RegisterScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  verifyEmail('/verify-email', AccessLevel.guestOnly, VerifyEmailScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  forgetPassword('/forget-password', AccessLevel.guestOnly, ForgetPasswordScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  resetPassword('/reset-password', AccessLevel.guestOnly, ResetPasswordScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  signInRequired('/sign-in-required', AccessLevel.guestOnly, SignInRequiredScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  home('/', AccessLevel.public, HomeScreen.new,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      isTab: true,
      appBar: AppBarMode.none),

  cart('/cart', AccessLevel.public, CartScreen.new,
      icon: Icons.shopping_bag_outlined,
      selectedIcon: Icons.shopping_bag_rounded,
      isTab: true),

  categories('/categories', AccessLevel.public, CategoriesScreen.new,
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view_rounded,
      isTab: true),

  account('/account', AccessLevel.authenticated, AccountScreen.new,
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      isTab: true,
      appBar: AppBarMode.none),

  settings('/settings', AccessLevel.public, SettingsScreen.new,
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      isTab: true),

  editProfile('/account/edit', AccessLevel.authenticated, EditProfileScreen.new,
      parent: account),

  checkout('/cart/checkout', AccessLevel.public, CheckoutScreen.new,
      parent: cart, fullScreen: true);

  const AppPage(
      this.path,
      this.access,
      this.builder, {
        this.icon,
        this.selectedIcon,
        this.parent,
        this.isTab = false,
        this.fullScreen = false,
        this.appBar = AppBarMode.standard,
      });

  final String path;
  final AccessLevel access;
  final Widget Function() builder;
  final IconData? icon;
  final IconData? selectedIcon;
  final AppPage? parent;
  final bool isTab;
  final bool fullScreen;
  final AppBarMode appBar;

  String titleOf(S l10n) => switch (this) {
    splash || login || register || verifyEmail ||
    forgetPassword || resetPassword || signInRequired => '',
    home => l10n.navHome,
    cart => l10n.navCart,
    categories => l10n.navCategories,
    account => l10n.navAccount,
    settings => l10n.settings,
    editProfile => l10n.pageEditProfile,
    checkout => l10n.pageCheckout,
  };

  bool get isAuthFlow =>
      this == splash ||
          this == login ||
          this == register ||
          this == verifyEmail ||
          this == forgetPassword ||
          this == resetPassword ||
          this == signInRequired;

  String get localPath {
    if (parent == null) return path;
    final base = parent!.path;
    return path.substring(base == '/' ? 1 : base.length + 1);
  }

  static List<AppPage> get tabs => [for (final p in values) if (p.isTab) p];

  static AppPage? match(String path) {
    final segs = path.split('/');
    for (final page in values) {
      final tpl = page.path.split('/');
      if (tpl.length != segs.length) continue;
      var ok = true;
      for (var i = 0; i < tpl.length && ok; i++) {
        ok = tpl[i].startsWith(':') || tpl[i] == segs[i];
      }
      if (ok) return page;
    }
    return null;
  }
}