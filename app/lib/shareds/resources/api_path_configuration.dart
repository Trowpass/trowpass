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
  _baseUrl: "https://trowpass-api.azurewebsites.net/",
};

Map<String, dynamic> prodBaseUrl = {
  _baseUrl: "",
};
