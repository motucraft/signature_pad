import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../provider/auth_controller.dart';

class Content extends HookConsumerWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signaturePadKey =
        useMemoized(GlobalKey<SfSignaturePadState>.new, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature Pad Demo'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async =>
                  await ref.read(authControllerProvider.notifier).signOut(),
              child: const Text('Sign Out'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: SfSignaturePad(
                  key: signaturePadKey,
                  backgroundColor: Colors.black12,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // TODO
                      final image =
                          await signaturePadKey.currentState?.toImage();
                      if (image == null) return;
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => signaturePadKey.currentState?.clear(),
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
