import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/network/dio_client.dart';

final dioProvider = Provider<Dio>((ref) => createDioClient());
