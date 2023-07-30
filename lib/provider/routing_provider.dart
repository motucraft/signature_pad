import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../view/content.dart';
import '../view/login.dart';
import 'auth_controller.dart';

part 'routing_provider.g.dart';

@riverpod
GoRouter routing(RoutingRef ref) {
  final router = GoRouter(
    routerNeglect: true,
    debugLogDiagnostics: true,
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authStateProvider);
      if (authState.valueOrNull == null) {
        return '/login';
      }

      return '/content';
    },
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage(child: Login());
        },
      ),
      GoRoute(
        path: '/content',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage(child: Content());
        },
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}
