import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class ApiConstants {
  static String get clientId => dotenv.env['CLIENT_ID'] ?? '';
  static String get clientSecret => dotenv.env['CLIENT_SECRET'] ?? '';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://bibliotaku.thejairex.dpdns.org';
}
