abstract final class ContactEndpoints {
  static const String _prefix = 'User/Contact';

  static const String getAll = '$_prefix/GetAll';
  static const String add = '$_prefix/Add';
  static String update(String id) => '$_prefix/Update/$id';
  static String setAsPrimary(String id) => '$_prefix/SetAsPrimary/$id';
  static String delete(String id) => '$_prefix/Delete/$id';
  static const String sendCode = '$_prefix/SendVerificationCode';
  static const String verify = '$_prefix/Verify';
}