import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';

Dio createDioClient() {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
}

Dio createSupabaseDioClient() {
  return Dio(
    BaseOptions(
      baseUrl: dotenv.env['SUPABASE_URL']!,
      headers: {
        'apikey': dotenv.env['SUPABASE_KEY']!,
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
}
