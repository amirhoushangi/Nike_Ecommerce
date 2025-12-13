import 'package:flutter/cupertino.dart';
import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.login(username, password);
      debugPrint("access token is: " + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      debugPrint("access token is: " + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refreshToken() {
    return dataSource.refreshToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoiYW1pcmg4MkBnbWFpbC5jb20iLCJpYXQiOjE3NjU2MjExMDYsImV4cCI6MTc2NjIyNTkwNn0.BhewYoODK5od9p_7ipzh5A8EX-rArGj3ElD6rkWGz_U");
  }
}
