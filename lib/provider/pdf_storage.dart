import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pdf_storage.g.dart';

@riverpod
class PdfStorage extends _$PdfStorage {
  @override
  FutureOr<String?> build() async {
    return null;
  }

  Future<void> uploadToStorage(Uint8List file) async {
    final fileId = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref().child('$fileId.pdf');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Save PDF file to Cloud Storage for Firebase.
      final taskSnapshot = await storageRef.putData(file);

      return await taskSnapshot.ref.getDownloadURL();
    });
  }
}
