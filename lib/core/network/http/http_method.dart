enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete;

  String get value => name.toUpperCase();
}