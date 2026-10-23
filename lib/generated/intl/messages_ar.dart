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

  static String m0(apartment) => "شقة ${apartment}";

  static String m1(building) => "مبنى ${building}";

  static String m2(street, city) =>
      "سيتم حذف ${street}، ${city} من عناوينك المحفوظة.";

  static String m3(floor) => "الدور ${floor}";

  static String m4(min) => "${min} أحرف على الأقل";

  static String m5(phone) =>
      "هل تريد حذف ${phone}؟ لا يمكن التراجع عن هذا الإجراء.";

  static String m6(phone) => "أدخل الرمز الذي أرسلناه إلى ${phone}.";

  static String m7(price) => "${price} ج.م";

  static String m8(appName) => "انضم إلى ${appName} وابدأ التسوق 🛒";

  static String m9(email) =>
      "أدخل الرمز المرسل إلى ${email} واختر كلمة مرور جديدة";

  static String m10(email) => "أدخل الرمز الذي أرسلناه إلى ${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountAddresses": MessageLookupByLibrary.simpleMessage("العناوين"),
    "accountContact": MessageLookupByLibrary.simpleMessage("معلومات التواصل"),
    "accountDeleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
    "accountDeleteAccountConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "سيتم حذف حسابك وبياناتك نهائياً. لا يمكن التراجع عن هذا الإجراء.",
    ),
    "accountDeleteAccountConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف حسابك؟",
    ),
    "accountDeleteAccountHint": MessageLookupByLibrary.simpleMessage(
      "إزالة حسابك وبياناتك نهائياً",
    ),
    "accountEditProfile": MessageLookupByLibrary.simpleMessage(
      "تعديل الملف الشخصي",
    ),
    "accountPhoneNumbers": MessageLookupByLibrary.simpleMessage("أرقام الهاتف"),
    "accountPreferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "accountSecurity": MessageLookupByLibrary.simpleMessage("أمان الحساب"),
    "accountTitle": MessageLookupByLibrary.simpleMessage("الحساب"),
    "addressesAddAction": MessageLookupByLibrary.simpleMessage("إضافة العنوان"),
    "addressesAddNew": MessageLookupByLibrary.simpleMessage("إضافة عنوان جديد"),
    "addressesAddTitle": MessageLookupByLibrary.simpleMessage("إضافة عنوان"),
    "addressesAdded": MessageLookupByLibrary.simpleMessage("تمت إضافة العنوان"),
    "addressesAdditionalInfoHint": MessageLookupByLibrary.simpleMessage(
      "علامات مميزة، ملاحظات للتوصيل…",
    ),
    "addressesApartment": m0,
    "addressesApartmentHint": MessageLookupByLibrary.simpleMessage("مثال: 5"),
    "addressesBuilding": m1,
    "addressesBuildingHint": MessageLookupByLibrary.simpleMessage("مثال: 12"),
    "addressesCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "addressesCityHint": MessageLookupByLibrary.simpleMessage("اختر المدينة"),
    "addressesCityRequired": MessageLookupByLibrary.simpleMessage(
      "من فضلك اختر المدينة",
    ),
    "addressesCountryHint": MessageLookupByLibrary.simpleMessage("اختر الدولة"),
    "addressesCountryRequired": MessageLookupByLibrary.simpleMessage(
      "من فضلك اختر الدولة",
    ),
    "addressesDefaultBadge": MessageLookupByLibrary.simpleMessage("افتراضي"),
    "addressesDefaultChanged": MessageLookupByLibrary.simpleMessage(
      "تم تغيير العنوان الافتراضي",
    ),
    "addressesDelete": MessageLookupByLibrary.simpleMessage("حذف"),
    "addressesDeleteMessage": m2,
    "addressesDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "حذف العنوان؟",
    ),
    "addressesDeleted": MessageLookupByLibrary.simpleMessage("تم حذف العنوان"),
    "addressesEditTitle": MessageLookupByLibrary.simpleMessage("تعديل العنوان"),
    "addressesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "أضف عنوان توصيل لإتمام الطلب بشكل أسرع.",
    ),
    "addressesEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "لا توجد عناوين بعد",
    ),
    "addressesFieldAdditionalInfo": MessageLookupByLibrary.simpleMessage(
      "معلومات إضافية",
    ),
    "addressesFieldApartment": MessageLookupByLibrary.simpleMessage("الشقة"),
    "addressesFieldBuilding": MessageLookupByLibrary.simpleMessage("المبنى"),
    "addressesFieldCity": MessageLookupByLibrary.simpleMessage("المدينة"),
    "addressesFieldCountry": MessageLookupByLibrary.simpleMessage("الدولة"),
    "addressesFieldFloor": MessageLookupByLibrary.simpleMessage("الدور"),
    "addressesFieldGovernorate": MessageLookupByLibrary.simpleMessage(
      "المحافظة",
    ),
    "addressesFieldPostalCode": MessageLookupByLibrary.simpleMessage(
      "الرمز البريدي",
    ),
    "addressesFieldRequired": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب",
    ),
    "addressesFieldStreet": MessageLookupByLibrary.simpleMessage("الشارع"),
    "addressesFloor": m3,
    "addressesFloorHint": MessageLookupByLibrary.simpleMessage("مثال: 3"),
    "addressesGenericError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ ما.",
    ),
    "addressesGovernorateHint": MessageLookupByLibrary.simpleMessage(
      "اختر المحافظة",
    ),
    "addressesGovernorateRequired": MessageLookupByLibrary.simpleMessage(
      "من فضلك اختر المحافظة",
    ),
    "addressesLoadFailedTitle": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل العناوين",
    ),
    "addressesMenuDelete": MessageLookupByLibrary.simpleMessage("حذف"),
    "addressesMenuEdit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "addressesMenuSetDefault": MessageLookupByLibrary.simpleMessage(
      "تعيين كافتراضي",
    ),
    "addressesPostalCodeHint": MessageLookupByLibrary.simpleMessage(
      "مثال: 11511",
    ),
    "addressesRetry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "addressesSaveChanges": MessageLookupByLibrary.simpleMessage(
      "حفظ التغييرات",
    ),
    "addressesSetAsDefault": MessageLookupByLibrary.simpleMessage(
      "تعيين كعنوان افتراضي",
    ),
    "addressesStreetHint": MessageLookupByLibrary.simpleMessage(
      "مثال: محور 26 يوليو",
    ),
    "addressesUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث العنوان",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("متجر"),
    "authConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "authConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أعد إدخال كلمة المرور",
    ),
    "authContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "المتابعة باستخدام جوجل",
    ),
    "authCreatePasswordHint": MessageLookupByLibrary.simpleMessage(
      "أنشئ كلمة مرور",
    ),
    "authEmail": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("name@example.com"),
    "authEmailInvalid": MessageLookupByLibrary.simpleMessage(
      "أدخل بريداً إلكترونياً صحيحاً",
    ),
    "authEmailRequired": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مطلوب",
    ),
    "authFirstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "authFirstNameHint": MessageLookupByLibrary.simpleMessage("مثال: محمد"),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "نسيت كلمة المرور؟",
    ),
    "authGender": MessageLookupByLibrary.simpleMessage("النوع"),
    "authGenderHint": MessageLookupByLibrary.simpleMessage("اختر النوع"),
    "authGenderRequired": MessageLookupByLibrary.simpleMessage("اختر النوع"),
    "authHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟",
    ),
    "authLastName": MessageLookupByLibrary.simpleMessage("اسم العائلة"),
    "authLastNameHint": MessageLookupByLibrary.simpleMessage("مثال: أحمد"),
    "authLogIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "authLogOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "authNewPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور الجديدة",
    ),
    "authNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور الجديدة",
    ),
    "authNoAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
    "authOr": MessageLookupByLibrary.simpleMessage("أو"),
    "authOtp": MessageLookupByLibrary.simpleMessage("رمز التحقق"),
    "authOtpHint": MessageLookupByLibrary.simpleMessage("أدخل الرمز"),
    "authOtpRequired": MessageLookupByLibrary.simpleMessage("رمز التحقق مطلوب"),
    "authPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور",
    ),
    "authPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور مطلوبة",
    ),
    "authPasswordTooShort": m4,
    "authPasswordsMismatch": MessageLookupByLibrary.simpleMessage(
      "كلمتا المرور غير متطابقتين",
    ),
    "authPhone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "authPhoneHint": MessageLookupByLibrary.simpleMessage("مثال: 01012345678"),
    "authPhoneRequired": MessageLookupByLibrary.simpleMessage(
      "رقم الهاتف مطلوب",
    ),
    "authRememberPassword": MessageLookupByLibrary.simpleMessage(
      "تتذكر كلمة المرور؟",
    ),
    "authSignUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "bannerFreeShippingSubtitle": MessageLookupByLibrary.simpleMessage(
      "على الطلبات فوق 500 ج.م",
    ),
    "bannerFreeShippingTitle": MessageLookupByLibrary.simpleMessage(
      "شحن مجاني",
    ),
    "bannerNewArrivalsSubtitle": MessageLookupByLibrary.simpleMessage(
      "أحدث الأنماط وصلت للتو",
    ),
    "bannerNewArrivalsTitle": MessageLookupByLibrary.simpleMessage(
      "وصل حديثاً",
    ),
    "bannerSeasonSaleSubtitle": MessageLookupByLibrary.simpleMessage(
      "خصم يصل إلى 50٪ على منتجات مختارة",
    ),
    "bannerSeasonSaleTitle": MessageLookupByLibrary.simpleMessage(
      "تخفيضات الموسم",
    ),
    "categoryBeauty": MessageLookupByLibrary.simpleMessage("جمال"),
    "categoryBooks": MessageLookupByLibrary.simpleMessage("كتب"),
    "categoryFashion": MessageLookupByLibrary.simpleMessage("أزياء"),
    "categoryHome": MessageLookupByLibrary.simpleMessage("المنزل"),
    "categoryLaptops": MessageLookupByLibrary.simpleMessage("لابتوب"),
    "categoryPhones": MessageLookupByLibrary.simpleMessage("هواتف"),
    "categorySports": MessageLookupByLibrary.simpleMessage("رياضة"),
    "commonCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "commonDelete": MessageLookupByLibrary.simpleMessage("حذف"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "commonSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
    ),
    "contactsAddAction": MessageLookupByLibrary.simpleMessage("إضافة"),
    "contactsAddNew": MessageLookupByLibrary.simpleMessage("إضافة رقم هاتف"),
    "contactsAddTitle": MessageLookupByLibrary.simpleMessage("إضافة رقم هاتف"),
    "contactsAdded": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة رقم الهاتف",
    ),
    "contactsCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "contactsCodeHint": MessageLookupByLibrary.simpleMessage(
      "رمز مكون من 6 أرقام",
    ),
    "contactsCodeSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز التحقق",
    ),
    "contactsDelete": MessageLookupByLibrary.simpleMessage("حذف"),
    "contactsDeleteMessage": m5,
    "contactsDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "حذف رقم الهاتف",
    ),
    "contactsDeleted": MessageLookupByLibrary.simpleMessage(
      "تم حذف رقم الهاتف",
    ),
    "contactsEditTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل رقم الهاتف",
    ),
    "contactsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "أضف رقم هاتف حتى نتمكن من التواصل معك بشأن طلباتك.",
    ),
    "contactsEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "لا توجد أرقام هاتف حتى الآن",
    ),
    "contactsFieldCode": MessageLookupByLibrary.simpleMessage("رمز التحقق"),
    "contactsFieldPhone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "contactsFieldRequired": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب",
    ),
    "contactsLoadFailedTitle": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل أرقام الهاتف",
    ),
    "contactsMenuDelete": MessageLookupByLibrary.simpleMessage("حذف"),
    "contactsMenuEdit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "contactsMenuSetPrimary": MessageLookupByLibrary.simpleMessage(
      "تعيين كرقم أساسي",
    ),
    "contactsPhoneDuplicate": MessageLookupByLibrary.simpleMessage(
      "هذا الرقم محفوظ بالفعل",
    ),
    "contactsPhoneHint": MessageLookupByLibrary.simpleMessage(
      "مثال: 01012345678",
    ),
    "contactsPhoneInvalid": MessageLookupByLibrary.simpleMessage(
      "أدخل رقم هاتف صحيحًا",
    ),
    "contactsPrimaryBadge": MessageLookupByLibrary.simpleMessage("أساسي"),
    "contactsPrimaryChanged": MessageLookupByLibrary.simpleMessage(
      "تم تغيير الرقم الأساسي",
    ),
    "contactsResendCode": MessageLookupByLibrary.simpleMessage(
      "إعادة إرسال الرمز",
    ),
    "contactsRetry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "contactsSaveChanges": MessageLookupByLibrary.simpleMessage(
      "حفظ التغييرات",
    ),
    "contactsUnverifiedBadge": MessageLookupByLibrary.simpleMessage(
      "لم يتم التحقق",
    ),
    "contactsUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث رقم الهاتف",
    ),
    "contactsVerified": MessageLookupByLibrary.simpleMessage(
      "تم التحقق من رقم الهاتف",
    ),
    "contactsVerifiedBadge": MessageLookupByLibrary.simpleMessage("تم التحقق"),
    "contactsVerifyAction": MessageLookupByLibrary.simpleMessage("تحقق"),
    "contactsVerifyMessage": m6,
    "contactsVerifySubmit": MessageLookupByLibrary.simpleMessage("تحقق"),
    "contactsVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "التحقق من رقم الهاتف",
    ),
    "failureCache": MessageLookupByLibrary.simpleMessage(
      "تعذّر حفظ إعداداتك، يرجى المحاولة مرة أخرى",
    ),
    "failureGeneric": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ ما، يرجى المحاولة مرة أخرى",
    ),
    "failureNetwork": MessageLookupByLibrary.simpleMessage(
      "لا يوجد اتصال بالإنترنت",
    ),
    "failureNoData": MessageLookupByLibrary.simpleMessage(
      "لا توجد بيانات محفوظة",
    ),
    "failureNotFound": MessageLookupByLibrary.simpleMessage(
      "العنصر المطلوب غير موجود",
    ),
    "failureServer": MessageLookupByLibrary.simpleMessage(
      "خطأ في الخادم، يرجى المحاولة لاحقًا",
    ),
    "failureSessionExpired": MessageLookupByLibrary.simpleMessage(
      "انتهت جلستك، يرجى تسجيل الدخول مرة أخرى",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("مطلوب"),
    "forgetPasswordButton": MessageLookupByLibrary.simpleMessage("إرسال الرمز"),
    "forgetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق",
    ),
    "forgetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز التحقق إلى بريدك الإلكتروني",
    ),
    "forgetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "نسيت كلمة المرور؟",
    ),
    "genderFemale": MessageLookupByLibrary.simpleMessage("أنثى"),
    "genderMale": MessageLookupByLibrary.simpleMessage("ذكر"),
    "homeBestSellers": MessageLookupByLibrary.simpleMessage("الأكثر مبيعاً"),
    "homeCategories": MessageLookupByLibrary.simpleMessage("الفئات"),
    "homeDeliverTo": MessageLookupByLibrary.simpleMessage("توصيل الي"),
    "homeLocationFallback": MessageLookupByLibrary.simpleMessage(
      "القاهرة، مصر",
    ),
    "homeNewArrivals": MessageLookupByLibrary.simpleMessage("وصل حديثاً"),
    "homeOnSale": MessageLookupByLibrary.simpleMessage("عروض وتخفيضات"),
    "homePreviouslyOrdered": MessageLookupByLibrary.simpleMessage(
      "الطلبات السابقة",
    ),
    "homeRecentlyViewed": MessageLookupByLibrary.simpleMessage("شوهدت مؤخرًا"),
    "homeRecommended": MessageLookupByLibrary.simpleMessage("موصى به لك"),
    "homeSearchHint": MessageLookupByLibrary.simpleMessage(
      "ابحث عن المنتجات والفئات...",
    ),
    "homeSeeAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "homeShopNow": MessageLookupByLibrary.simpleMessage("تسوق الآن"),
    "homeWelcome": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك 👋"),
    "languageSystem": MessageLookupByLibrary.simpleMessage("النظام"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "سجّل الدخول لمتابعة التسوق 🛍️",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك"),
    "logoutSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الخروج بنجاح",
    ),
    "navAccount": MessageLookupByLibrary.simpleMessage("حسابي"),
    "navCart": MessageLookupByLibrary.simpleMessage("السلة"),
    "navCategories": MessageLookupByLibrary.simpleMessage("الفئات"),
    "navHome": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "navWishlist": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "pageAddresses": MessageLookupByLibrary.simpleMessage("العناوين"),
    "pageCheckout": MessageLookupByLibrary.simpleMessage("إتمام الشراء"),
    "pageContacts": MessageLookupByLibrary.simpleMessage("جهات الاتصال"),
    "pageEditProfile": MessageLookupByLibrary.simpleMessage(
      "تعديل الملف الشخصي",
    ),
    "priceEgp": m7,
    "profileChooseGallery": MessageLookupByLibrary.simpleMessage(
      "اختيار من المعرض",
    ),
    "profileEmail": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "profileFieldRequired": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب",
    ),
    "profileFirstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "profileGender": MessageLookupByLibrary.simpleMessage("النوع"),
    "profileLastName": MessageLookupByLibrary.simpleMessage("اسم العائلة"),
    "profilePickFailed": MessageLookupByLibrary.simpleMessage(
      "تعذر فتح منتقي الصور",
    ),
    "profilePictureUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الصورة الشخصية",
    ),
    "profileRemovePhoto": MessageLookupByLibrary.simpleMessage("حذف الصورة"),
    "profileSave": MessageLookupByLibrary.simpleMessage("حفظ التغييرات"),
    "profileTakePhoto": MessageLookupByLibrary.simpleMessage("التقاط صورة"),
    "profileUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الملف الشخصي",
    ),
    "registerButton": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "registerSubtitle": m8,
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحساب. يرجى تأكيد بريدك الإلكتروني.",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "resetPasswordButton": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "resetPasswordSubtitle": m9,
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "تمت إعادة تعيين كلمة المرور بنجاح",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "settingsAccount": MessageLookupByLibrary.simpleMessage("الحساب"),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("اللغة"),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("المظهر"),
    "signInRequiredAction": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول",
    ),
    "signInRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "تحتاج إلى حساب للوصول إلى هذه الصفحة. سجّل الدخول أو أنشئ حسابًا للبدء.",
    ),
    "signInRequiredSignUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "signInRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "سجّل الدخول للمتابعة",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("داكن"),
    "themeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("النظام"),
    "verifyEmailButton": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "verifyEmailOtpResent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز جديد إلى بريدك الإلكتروني",
    ),
    "verifyEmailResend": MessageLookupByLibrary.simpleMessage(
      "إعادة إرسال الرمز",
    ),
    "verifyEmailSubtitle": m10,
    "verifyEmailSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد البريد الإلكتروني بنجاح",
    ),
    "verifyEmailTitle": MessageLookupByLibrary.simpleMessage(
      "تأكيد البريد الإلكتروني",
    ),
  };
}
