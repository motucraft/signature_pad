import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../provider/auth_controller.dart';
import '../provider/pdf_storage.dart';
import '../util/logger.dart';
import 'signature_pdf.dart';

class Content extends HookConsumerWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signaturePadKey =
        useMemoized(GlobalKey<SfSignaturePadState>.new, const []);

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Digital Signature Demo'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async => await ref
                        .read(authControllerProvider.notifier)
                        .signOut(),
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Signature'),
                  Tab(text: 'Uploaded File'),
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  SignaturePdf(signaturePadKey: signaturePadKey),
                  ref.watch(pdfStorageProvider).when(
                        data: (data) {
                          if (data == null) {
                            return const Center(
                                child: Text('Not yet uploaded'));
                          }

                          return SfPdfViewer.network(data);
                        },
                        error: (error, stack) {
                          logger.severe(error);
                          logger.severe(stack);
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
