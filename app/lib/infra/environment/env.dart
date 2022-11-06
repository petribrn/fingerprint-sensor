import 'package:envied/envied.dart';

part 'env.g.dart';

/// Run 'flutter pub run build_runner build --delete-conflicting-outputs'
/// to build the generated file for this code

@Envied(path: '.env')
abstract class Environment {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static final apiUrl = _Environment.apiUrl;
}
