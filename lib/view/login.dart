import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../provider/auth_controller.dart';
import '../provider/loading_provider.dart';
import '../util/logger.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SignInButton(
            buttonType: ButtonType.github,
            onPressed: () async {
              logger.info('onPressed');
              ref.read(loadingProvider.notifier).present();
              await ref
                  .read(authControllerProvider.notifier)
                  .signInWithGithub();
            },
          ),
        ),
      ),
    );
  }
}
