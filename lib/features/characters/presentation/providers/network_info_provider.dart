import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shinobi_desk/core/network/network_info.dart';

final internetConnectionCheckerProvider = Provider<InternetConnectionChecker>((
  ref,
) {
  return InternetConnectionChecker.createInstance();
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(ref.watch(internetConnectionCheckerProvider));
});
