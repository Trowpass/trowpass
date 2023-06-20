import '../enums/environment.dart';

const _baseUrl = '';
dynamic _config;

String getBaseUrlOnEnvironment(Environment environment) {
  switch (environment) {
    case Environment.dev:
      _config = devBaseUrl;
      break;
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

Map<String, dynamic> devBaseUrl = {
  _baseUrl: "",
};

Map<String, dynamic> staggingBaseUrl = {
  _baseUrl: "",
};

Map<String, dynamic> prodBaseUrl = {
  _baseUrl: "",
};
