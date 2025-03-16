import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/auth/domain/domain.dart';
import 'package:technical_test/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String user, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final token = await authRepository.login(user, password);
      _setLoggedUser(token);
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    }
  }

  void checkAuthStatus() async {}

  void _setLoggedUser(Token token) {
    // TODO::Guardar el token
    state = state.copyWith(
      token: token,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout({String? errorMessage}) async {
    // TODO: Eliminar Token

    state = state.copyWith(
      token: null,
      authStatus: AuthStatus.noAutenticated,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { checking, authenticated, noAutenticated }

class AuthState {
  final AuthStatus authStatus;
  final Token? token;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.token,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    Token? token,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    token: token ?? this.token,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
