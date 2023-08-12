import '../enums/environment.dart';

const _baseUrl = '';
dynamic _config;

String getBaseUrlOnEnvironment(Environment environment) {
  switch (environment) {
    case Environment.staging:
      _config = staggingBaseUrl;
      break;
    case Environment.prod:
      _config = prodBaseUrl;
      break;
    default:
      break;
  }

  return _config[_baseUrl];
}

Map<String, dynamic> staggingBaseUrl = {
  _baseUrl: "http://samaon-001-site1.htempurl.com/",
};

Map<String, dynamic> prodBaseUrl = {
  _baseUrl: "",
};
