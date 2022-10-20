import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName => '.env';

  static String get apiUrl => dotenv.get('API_URL', fallback: 'API_URL não encontrada.');
}
