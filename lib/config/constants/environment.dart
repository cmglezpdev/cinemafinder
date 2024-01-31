
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDBKey = dotenv.env['THE_MOVIEDB_API_KEY'] ?? 'The MovieDB Key Not Found';
}