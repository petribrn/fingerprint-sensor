import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

import '../../contracts/contracts.dart';

class GetxSobreController extends GetxController implements SobreController {
  final _appVersion = ''.obs;
  final _appReleaseDate = ''.obs;

  @override
  String get appReleaseDate => _appReleaseDate.value;

  @override
  String get appVersion => _appVersion.value;

  @override
  Future<void> onReady() async {
    super.onReady();

    final file = await rootBundle.loadString('pubspec.yaml');
    final yaml = loadYaml(file) as Map<dynamic, dynamic>;

    final releaseDate = yaml['release_date'] as String;

    final packageInfo = await PackageInfo.fromPlatform();

    _appVersion.value = '${packageInfo.version}.${packageInfo.buildNumber}';
    _appReleaseDate.value = releaseDate;
  }
}
