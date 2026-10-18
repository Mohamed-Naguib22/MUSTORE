import 'package:flutter/material.dart';
import 'package:mustore/core/utils/enums/access_level.dart';
import 'package:mustore/app/router/screens/splash_screen.dart';
import 'package:mustore/features/auth/presentation/screens/login_screen.dart';
import 'package:mustore/features/auth/presentation/screens/register_screen.dart';
import 'package:mustore/features/catalog/presentation/screens/categories_screen.dart';
import 'package:mustore/features/home/presentation/screens/home_screen.dart';
import 'package:mustore/features/profile/presentation/screens/account_screen.dart';
import 'package:mustore/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mustore/features/settings/presentation/screens/settings_screen.dart';
import 'package:mustore/features/shopping/presentation/screens/cart_screen.dart';
import 'package:mustore/features/shopping/presentation/screens/checkout_screen.dart';

enum AppBarMode { standard, none }

enum AppPage {
  splash('/splash', AccessLevel.public, SplashScreen.new, appBar: AppBarMode.none),

  login('/login', AccessLevel.guestOnly, LoginScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  register('/register', AccessLevel.guestOnly, RegisterScreen.new,
      parent: home, fullScreen: true, appBar: AppBarMode.none),

  home('/', AccessLevel.public, HomeScreen.new,
      title: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      isTab: true,
      appBar: AppBarMode.none),

  cart('/cart', AccessLevel.public, CartScreen.new,
      title: 'Cart',
      icon: Icons.shopping_bag_outlined,
      selectedIcon: Icons.shopping_bag_rounded,
      isTab: true),

  categories('/categories', AccessLevel.public, CategoriesScreen.new,
      title: 'Categories',
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view_rounded,
      isTab: true),

  account('/account', AccessLevel.authenticated, AccountScreen.new,
      title: 'Account',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      isTab: true),

  settings('/settings', AccessLevel.public, SettingsScreen.new,
      title: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      isTab: true),

  editProfile('/account/edit', AccessLevel.authenticated, EditProfileScreen.new,
      title: 'Edit profile', parent: account),

  checkout('/cart/checkout', AccessLevel.public, CheckoutScreen.new,
      title: 'Checkout', parent: cart, fullScreen: true);

  const AppPage(
      this.path,
      this.access,
      this.builder, {
        this.title = '',
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
  final String title;
  final IconData? icon;
  final IconData? selectedIcon;
  final AppPage? parent;
  final bool isTab;
  final bool fullScreen;
  final AppBarMode appBar;

  bool get isAuthFlow => this == splash || this == login || this == register;

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