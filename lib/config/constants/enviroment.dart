import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String apiUrl = dotenv.env['API_URL'] ?? 'Url no asignada';
  static String apiKey = dotenv.env['API_KEY'] ?? 'Key no asignada';
}