import 'package:flutter/foundation.dart';

class Logging
{
  static void log(Object ctx, dynamic x) { if (kDebugMode) { print('<$ctx> $x'); } }
}