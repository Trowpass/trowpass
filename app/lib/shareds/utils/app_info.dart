import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  static Future<AppInfo> getInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return AppInfo(
      appName: appName,
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
    );
  }
}
