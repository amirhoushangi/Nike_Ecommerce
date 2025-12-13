import 'package:flutter/cupertino.dart';
import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(
    this.dataSource,
  );
  @override
  Future<void> login(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.login(username, password);
       _persistAuthTokens(authInfo);
      debugPrint("access token is: " + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
       _persistAuthTokens(authInfo);
      debugPrint("access token is: " + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImVtYWlsIjoiYW1pcmhAZ21haWwuY29tIiwiaWF0IjoxNzY1NjIwOTYyLCJleHAiOjE3NjYyMjU3NjJ9.j0lC9OBgtnMP5giwtphOpKR3KbYjS-184Zcln4aby4M");
     _persistAuthTokens(authInfo);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String accessToken =
        sharedPreferences.getString("access_token") ?? '';
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? '';

    debugPrint("loadAuthInfo()");
    debugPrint("access_token=$accessToken");
    debugPrint("refresh_token=$refreshToken");

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken);
      debugPrint("authinfo loaded into notifier");
    } else {
      debugPrint("tokens are empty");
    }
  }
}
