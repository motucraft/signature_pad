import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/loading_provider.dart';
import '../provider/pdf_storage.dart';

class SignaturePdf extends HookConsumerWidget {
  final GlobalKey<SfSignaturePadState> signaturePadKey;

  const SignaturePdf({super.key, required this.signaturePadKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentBytes = useState<Uint8List?>(null);
    final isSigned = useState(false);

    final storageUrlAsyncValue = ref.watch(pdfStorageProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (documentBytes.value != null)
            Expanded(
              child: SfPdfViewer.memory(
                documentBytes.value!,
                canShowSignaturePadDialog: false,
              ),
            ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: SfSignaturePad(
              key: signaturePadKey,
              backgroundColor: Colors.black12,
              onDrawEnd: () => isSigned.value = true,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isSigned.value)
                ElevatedButton(
                  onPressed: () async {
                    await _handleSigningProcess(signaturePadKey, documentBytes);
                  },
                  child: const Text('Add signature'),
                ),
              if (documentBytes.value != null)
                Wrap(
                  children: [
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final uploadToStorage = ref
                            .read(pdfStorageProvider.notifier)
                            .uploadToStorage(documentBytes.value!);
                        await ref
                            .read(loadingProvider.notifier)
                            .wrap(uploadToStorage);

                        signaturePadKey.currentState?.clear();
                        documentBytes.value = null;
                        isSigned.value = false;
                      },
                      child: const Text('Upload'),
                    ),
                  ],
                ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  signaturePadKey.currentState?.clear();
                  documentBytes.value = null;
                  isSigned.value = false;
                  ref.invalidate(pdfStorageProvider);
                },
                child: const Text('Clear'),
              ),
            ],
          ),
          if (storageUrlAsyncValue is AsyncData &&
              storageUrlAsyncValue.valueOrNull != null)
            Column(
              children: [
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(storageUrlAsyncValue.value!));
                  },
                  child: const Text('Open uploaded file in browser'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _handleSigningProcess(
      GlobalKey<SfSignaturePadState> signaturePadKey,
      ValueNotifier<Uint8List?> documentBytes) async {
    // Save the signature as PNG image
    final data = await signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
    final bytes = await data?.toByteData(format: ui.ImageByteFormat.png);
    final ByteData docBytes = await rootBundle.load('assets/pdf/invoice.pdf');
    ByteData certBytes = await rootBundle.load('assets/cert/certificate.pfx');
    final Uint8List certificateBytes = certBytes.buffer.asUint8List();

    //  Load the document
    final document = PdfDocument(inputBytes: docBytes.buffer.asUint8List());

    try {
      // Get the first page of the document. The page in which signature need to be added.
      PdfPage page = document.pages[0];

      // Create a digital signature and set the signature information
      PdfSignatureField signatureField = PdfSignatureField(
        page,
        'signature',
        bounds: const Rect.fromLTRB(300, 500, 550, 700),
        signature: PdfSignature(
          // Create a certificate instance from the PFX file with a private key.
          // password:No problem as it is a sample self-signed certificate.
          certificate: PdfCertificate(certificateBytes, 'password123'),
          digestAlgorithm: DigestAlgorithm.sha256,
          cryptographicStandard: CryptographicStandard.cms,
        ),
      );

      // Get the signature field appearance graphics.
      PdfGraphics? graphics = signatureField.appearance.normal.graphics;

      // Draw the signature image in the PDF page.
      graphics?.drawImage(PdfBitmap(bytes!.buffer.asUint8List()),
          const Rect.fromLTWH(0, 0, 250, 100));

      // Add a signature field to the form.
      document.form.fields.add(signatureField);

      // Flatten the PDF form field annotation.
      document.form.flattenAllFields();

      documentBytes.value = Uint8List.fromList(await document.save());
    } finally {
      document.dispose();
    }
  }
}
