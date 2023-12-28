import 'package:dio/dio.dart';
import 'package:reskolae/utils/logging.dart';

/// Reverse-engineered MyGES auth methods & other nice utilities.
/// Thanks to tchenu aka TC.
/// -- Erwan
class MyGES
{
  // Class members
  static const _oauthAuthorizeUrl = 'https://authentication.kordis.fr/oauth/authorize?client_id={clientID}&response_type=token';
  final Dio _dioClient = Dio();

  // Constructors
  MyGES();

  // Helper methods
  // String? _extractAccessToken() { return '!impl'; }

  Future<String?> authenticate(
    {
      required String clientID,
      required String username,
      required String password,
    }
  ) async
  {
    final authEndpoint = _oauthAuthorizeUrl.replaceAll('{clientID}', clientID);

    Logging.log(this, 'clientID=$clientID | user=$username | password=$password');

    final response = await _dioClient.get(authEndpoint, data: { 'auth': [username, password], 'allow_redirects': false, 'http_errors': false });

    if ( response.statusCode == 401 )
    {
      Logging.log(this, 'user authentication: 401 Unauthorized.');
      throw Exception('401 Unauthorized');
    }

    if (!response.data.access_token)
    {
      Logging.log(this, 'user authentication: access token couldn\'t be found.');
      throw Exception('No access token data');
    }

    return response.data.access_token;
  }
}