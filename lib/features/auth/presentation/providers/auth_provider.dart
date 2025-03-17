import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/auth/domain/domain.dart';
import 'package:technical_test/features/auth/infrastructure/infrastructure.dart';
import 'package:technical_test/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:technical_test/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String user, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final token = await authRepository.login(user, password);
      _setLoggedUser(token);
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    }
  }

  void checkAuthStatus() async {
    final tokenStoraged = await keyValueStorageService.getValue<String>(
      'token',
    );

    if (tokenStoraged == null) return logout();

    try {
      final token = await authRepository.checkAuthStatus(tokenStoraged);
      _setLoggedUser(token);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(Token token) async {
    await keyValueStorageService.setKeyValue('token', token.token);
    state = state.copyWith(
      token: token,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout({String? errorMessage}) async {
    await keyValueStorageService.removeKey('token');

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
