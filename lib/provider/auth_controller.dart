import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

@riverpod
class AuthController extends _$AuthController {
  final _auth = FirebaseAuth.instance;

  @override
  FutureOr<User?> build() async {
    _auth.userChanges().listen((user) {
      state = AsyncValue.data(user);
    });

    return state.value;
  }

  Future<void> signInWithGithub() async {
    final githubProvider = GithubAuthProvider();
    state = const AsyncLoading<User?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      // final userCredential = await _auth.signInWithPopup(_githubProvider);
      final userCredential = await _auth.signInWithProvider(githubProvider);
      return userCredential.user;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading<User?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      await _auth.signOut();
      return null;
    });
  }
}
