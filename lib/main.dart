import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'provider/auth_controller.dart';
import 'provider/loading_provider.dart';
import 'provider/routing_provider.dart';
import 'util/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.userChanges().first;

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (_, __) {
      ref.read(loadingProvider.notifier).dismiss();
      logger.info('invalidate routingProvider');
      ref.invalidate(routingProvider);
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      routerConfig: ref.watch(routingProvider),
      builder: (_, Widget? child) {
        return Stack(
          children: [
            if (child != null) child,
            Consumer(
              builder: (context, ref, child) {
                final isLoading = ref.watch(loadingProvider);
                if (isLoading) {
                  return const ColoredBox(
                    color: Colors.black54,
                    child: Center(
                      child: SpinKitDualRing(
                        color: Colors.lightGreen,
                        size: 100,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}
