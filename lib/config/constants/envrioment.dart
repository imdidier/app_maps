import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String apiKeyGoogleMaps = dotenv.env['GOOGLE_MAP_APIKEY'] ?? '';
}
