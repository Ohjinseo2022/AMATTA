import 'package:amatta_front/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    routes: provider.routes,
    // initialLocation: '/splash',
    redirect: (_, state) => provider.redirectLogic(state),
    debugLogDiagnostics: true,
  );
});
