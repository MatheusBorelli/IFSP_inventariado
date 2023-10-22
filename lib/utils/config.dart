import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get baseURL => _get('API_URL');

  static String _get(String name) => dotenv.get('API_URL', fallback: '');
}