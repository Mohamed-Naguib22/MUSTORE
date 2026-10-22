abstract final class AddressEndpoints {
  static const String _prefix = 'User/Address';

  static const String getAll = '$_prefix/GetAll';
  static const String add = '$_prefix/Add';
  static String update(String id) => '$_prefix/Update/$id';
  static String setAsDefault(String id) => '$_prefix/SetAsDefault/$id';
  static String delete(String id) => '$_prefix/Delete/$id';
}