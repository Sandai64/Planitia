import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reskolae/models/user.dart';
import 'package:reskolae/utils/logging.dart';
import 'package:reskolae/utils/str.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  Future<User?> authenticate(String username, String password) async
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

    final accessToken = location[0].split('=')[1];
    final expiresIn   = int.parse(location[2].split('=')[1]);

    for (var elem in [username, accessToken, expiresIn, location])
    {
      Logging.log(this, 'login process : $elem');
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('user.username', username);
    prefs.setString('user.password', password);
    prefs.setString('auth.token.value', accessToken);
    prefs.setInt('auth.token.eol', expiresIn);
    throw Exception();
  }

  Future<User?> getUserData(String authToken) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dioClient = Dio();

    dioClient.options.headers['Authorization'] = 'Bearer ${prefs.getString('auth.token.value')}';


  }
}