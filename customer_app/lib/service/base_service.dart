import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class BaseService {
  static Map<String, String> getHeaders({String? token}) {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${token ?? ""}",
      HttpHeaders.contentTypeHeader: "application/json"
    };
  }

  static Future<Map<String, dynamic>?> getData(String uri,
      {String? token}) async {
    http.Response response =
        await http.get(Uri.parse(uri), headers: getHeaders(token: token));
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postData(
      String uri, Map<String, dynamic> params) async {
    http.Response response = await http.Client()
        .post(Uri.parse(uri), headers: getHeaders(), body: jsonEncode(params));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  // static Future<Map<String, dynamic>?> safeGetData(
  //     String uri, BuildContext context) async {
  //   var tokenInDate = await checkToken();
  //   if (tokenInDate) {
  //     String? currentToken = await SharedPref.read(SharedPrefPath.token);
  //     return getData(uri, token: currentToken);
  //   }
  //   var refreshTokenInDate = await checkRefreshToken();
  //   if (refreshTokenInDate) {
  //     String currentRefreshToken =
  //         await SharedPref.read(SharedPrefPath.refreshToken);
  //     var newToken = await getToken(currentRefreshToken);
  //     if (newToken != null) {
  //       SharedPref.save(SharedPrefPath.token, newToken);
  //       return getData(uri, token: newToken);
  //     }
  //   }
  //   BlocProvider.of<AppCubit>(context).timeout(context);
  //   return null;
  // }

  // /// Support Function
  // static Future<bool> checkToken() async {
  //   String? currentToken = await SharedPref.read(SharedPrefPath.token);
  //   if (currentToken != null && !isTokenExpired(currentToken)) {
  //     return true;
  //   }
  //   return false;
  // }

  // static Future<bool> checkRefreshToken() async {
  //   String? currentRefreshToken =
  //       await SharedPref.read(SharedPrefPath.refreshToken);
  //   if (currentRefreshToken != null && !isTokenExpired(currentRefreshToken)) {
  //     return true;
  //   }
  //   return false;
  // }

  static bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Future<String?> getToken(String refreshToken) async {
    // TODO: Get token by refresh token
    return null;
  }
}