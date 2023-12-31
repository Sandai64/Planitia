import 'dart:convert';
import 'dart:typed_data';

class Strutils
{
  static String base64encode(String src)
  {
    final Uint8List bytes = utf8.encode(src);
    return base64.encode(bytes);
  }

  static String base64decode(String enc)
  {
    final Uint8List bytes = base64.decode(enc);
    return utf8.decode(bytes);
  }
}