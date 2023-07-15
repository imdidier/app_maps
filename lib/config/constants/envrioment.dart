import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tokenMapBox = dotenv.env['TOKEN_MAPBOX'] ?? '';
}
