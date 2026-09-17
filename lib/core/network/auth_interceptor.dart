import 'package:dio/dio.dart';
import 'package:shinobi_desk/core/constant/supabase_constants.dart';
import 'package:shinobi_desk/core/network/auth_local_storage.dart';
import 'package:shinobi_desk/features/auth/data/models/app_user_model.dart';

class AuthInterceptor extends QueuedInterceptor {
  final AuthLocalStorage tokenStorage;
  final Dio dio;

  AuthInterceptor({required this.tokenStorage, required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      handler.next(
        err,
      ); // Pas un problème de token, on laisse remonter tel quel
      return;
    }

    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      handler.next(err); // Rien à rafraîchir, on laisse remonter
      return;
    }

    try {
      final response = await dio.post(
        SupabaseConstants.tokenPath,
        queryParameters: {'grant_type': 'refresh_token'},
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'] as String;
      final newRefreshToken = response.data['refresh_token'] as String;
      final newUser = AppUserModel.fromJson(response.data['user']);

      await tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
        user: newUser,
      );

      // On rejoue la requête d'origine avec le nouveau token.
      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await dio.fetch(retryOptions);

      handler.resolve(
        retryResponse,
      ); // L'appelant ne voit jamais l'échec initial
    } catch (_) {
      // Refresh token invalide/expiré : impossible de récupérer la session.
      await tokenStorage.clearTokens();
      handler.next(err); // L'erreur remonte, l'utilisateur devra se reconnecter
    }
  }
}
