// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(price) => "${price} ج.م";

  static String m1(appName) => "انضم إلى ${appName} وابدأ التسوق";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("متجر"),
        "authConfirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
        "authConfirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("أعد إدخال كلمة المرور"),
        "authCreatePasswordHint":
            MessageLookupByLibrary.simpleMessage("أنشئ كلمة مرور"),
        "authEmail": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "authEmailHint":
            MessageLookupByLibrary.simpleMessage("name@example.com"),
        "authFirstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
        "authFirstNameHint":
            MessageLookupByLibrary.simpleMessage("أدخل اسمك الأول"),
        "authForgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "authGender": MessageLookupByLibrary.simpleMessage("النوع"),
        "authGenderHint": MessageLookupByLibrary.simpleMessage("اختر النوع"),
        "authGenderRequired":
            MessageLookupByLibrary.simpleMessage("اختر النوع"),
        "authHaveAccount":
            MessageLookupByLibrary.simpleMessage("لديك حساب بالفعل؟"),
        "authLastName": MessageLookupByLibrary.simpleMessage("اسم العائلة"),
        "authLastNameHint":
            MessageLookupByLibrary.simpleMessage("أدخل اسم العائلة"),
        "authLogIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "authNoAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "authPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "authPasswordHint":
            MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
        "authPasswordRequired":
            MessageLookupByLibrary.simpleMessage("كلمة المرور مطلوبة"),
        "authPasswordsMismatch":
            MessageLookupByLibrary.simpleMessage("كلمتا المرور غير متطابقتين"),
        "authPhone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "authPhoneHint":
            MessageLookupByLibrary.simpleMessage("مثال: 01012345678"),
        "authPhoneRequired":
            MessageLookupByLibrary.simpleMessage("رقم الهاتف مطلوب"),
        "authSignUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "bannerFreeShippingSubtitle":
            MessageLookupByLibrary.simpleMessage("على الطلبات فوق 500 ج.م"),
        "bannerFreeShippingTitle":
            MessageLookupByLibrary.simpleMessage("شحن مجاني"),
        "bannerNewArrivalsSubtitle":
            MessageLookupByLibrary.simpleMessage("أحدث الأنماط وصلت للتو"),
        "bannerNewArrivalsTitle":
            MessageLookupByLibrary.simpleMessage("وصل حديثاً"),
        "bannerSeasonSaleSubtitle": MessageLookupByLibrary.simpleMessage(
            "خصم يصل إلى 50٪ على منتجات مختارة"),
        "bannerSeasonSaleTitle":
            MessageLookupByLibrary.simpleMessage("تخفيضات الموسم"),
        "categoryBeauty": MessageLookupByLibrary.simpleMessage("جمال"),
        "categoryBooks": MessageLookupByLibrary.simpleMessage("كتب"),
        "categoryFashion": MessageLookupByLibrary.simpleMessage("أزياء"),
        "categoryHome": MessageLookupByLibrary.simpleMessage("المنزل"),
        "categoryLaptops": MessageLookupByLibrary.simpleMessage("لابتوب"),
        "categoryPhones": MessageLookupByLibrary.simpleMessage("هواتف"),
        "categorySports": MessageLookupByLibrary.simpleMessage("رياضة"),
        "fieldRequired": MessageLookupByLibrary.simpleMessage("مطلوب"),
        "genderFemale": MessageLookupByLibrary.simpleMessage("أنثى"),
        "genderMale": MessageLookupByLibrary.simpleMessage("ذكر"),
        "homeBestSellers":
            MessageLookupByLibrary.simpleMessage("الأكثر مبيعاً"),
        "homeCategories": MessageLookupByLibrary.simpleMessage("الفئات"),
        "homeNewArrivals": MessageLookupByLibrary.simpleMessage("وصل حديثاً"),
        "homeSearchHint":
            MessageLookupByLibrary.simpleMessage("ابحث عن المنتجات والفئات..."),
        "homeSeeAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
        "homeShopNow": MessageLookupByLibrary.simpleMessage("تسوق الآن"),
        "homeWelcome": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك 👋"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("النظام"),
        "loginSubtitle":
            MessageLookupByLibrary.simpleMessage("سجّل الدخول لمتابعة التسوق"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك"),
        "priceEgp": m0,
        "registerButton": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "registerSubtitle": m1,
        "registerSuccess": MessageLookupByLibrary.simpleMessage(
            "تم إنشاء الحساب. يرجى تسجيل الدخول."),
        "registerTitle": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "settingsLanguage": MessageLookupByLibrary.simpleMessage("اللغة"),
        "settingsTheme": MessageLookupByLibrary.simpleMessage("المظهر"),
        "themeDark": MessageLookupByLibrary.simpleMessage("داكن"),
        "themeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
        "themeSystem": MessageLookupByLibrary.simpleMessage("النظام")
      };
}
