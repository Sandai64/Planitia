import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reskolae/utils/logging.dart';
import 'package:reskolae/utils/str.dart';

/// Reverse-engineered MyGES auth methods & other nice utilities.
/// Thanks to tchenu aka TC.
/// -- Erwan
class MyGES
{
  // Class members
  static const _oauthAuthorizeUrl = 'https://authentication.kordis.fr/oauth/authorize?client_id=skolae-app&response_type=token';

  // Constructors
  MyGES();

  // Helper methods
  Future<dynamic> authenticate(String username, String password) async
  {
    final Dio dioClient = Dio();
    dioClient.options.headers['Authorization'] = 'Basic ${Strutils.base64encode('$username:$password')}';

    // Spoof ReSkolae as regular skolae app
    // -- For some boneheaded reason these guys thought it'd be a good idea to hide the authentication token
    // inside the response header. Response, which points to their own retarded protocol (comreseaugesskolae:/oauth2redirect#access_token=...)
    // Use standards you fucks. Spent three days debugging your shit.
    final result = await dioClient.get(_oauthAuthorizeUrl, options: Options(
      followRedirects: false,
      validateStatus: (status) { return status! < 500; }
    ));

    final location = result.headers.value('Location')!.split('&');

    final access_token = location[0].split('=')[1];
    final expires_in   = int.parse(location[2].split('=')[1]);

    inspect([access_token, expires_in]);
  }
}