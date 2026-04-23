import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/auth_response_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/oauth/token',
        data: {
          'grant_type': 'password',
          'username': email.trim(),
          'password': password,
          'client_id': ApiConstants.clientId,
          'client_secret': ApiConstants.clientSecret,
          'scope': '',
        },
      );

      final data = Map<String, dynamic>.from(response.data as Map);
      final model = AuthResponseModel.fromJson(data);

      await _storage.write(key: 'access_token', value: model.accessToken);
      await _storage.write(key: 'refresh_token', value: model.refreshToken);

      return model;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<bool> hasSession() async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }

  Future<AuthResponseModel> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');

    if (refreshToken == null) {
      throw Exception('No hay token de refresco');
    }

    final response = await _dio.post(
      '/oauth/token',
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': ApiConstants.clientId,
        'client_secret': ApiConstants.clientSecret,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al refrescar token: ${response.data}');
    }

    final model = AuthResponseModel.fromJson(response.data);

    await _storage.write(key: 'access_token', value: model.accessToken);
    await _storage.write(key: 'refresh_token', value: model.refreshToken);

    return model;
  }
}
