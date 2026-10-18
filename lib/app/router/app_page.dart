import 'access_level.dart';

enum AppPage {
  splash('/splash', AccessLevel.public),
  login('/login', AccessLevel.guestOnly),
  register('/register', AccessLevel.guestOnly),
  home('/', AccessLevel.public),
  cart('/cart', AccessLevel.public),
  account('/account', AccessLevel.authenticated),
  categories('/categories', AccessLevel.public),
  settings('/settings', AccessLevel.public);

  const AppPage(this.path, this.access);

  final String path;
  final AccessLevel access;

  bool get isAuthFlow => this == splash || this == login || this == register;

  static AppPage? match(String path) {
    for (final page in values) {
      if (page.path == path) return page;
    }
    return null;
  }
}