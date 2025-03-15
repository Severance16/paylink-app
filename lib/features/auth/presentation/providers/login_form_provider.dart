import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:technical_test/features/shared/shared.dart';

final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final User user;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.user = const User.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    User? user,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    user: user ?? this.user,
    password: password ?? this.password,
  );

  @override
  String toString() {
    return '''
      LoginFormState
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      user: $user
      password: $password
    ''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  onUserChange(String value) {
    final newUser = User.dirty(value);
    state = state.copyWith( 
      user: newUser, 
      isValid: Formz.validate([ newUser, state.password])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith( 
      password: newPassword, 
      isValid: Formz.validate([ newPassword, state.user])
    );
  }

  onFormSubmit() {
    _touchEveryField();

    if (!state.isValid) return;

    print(state);
  }

  _touchEveryField() {
    final user = User.dirty(state.user.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      user: user,
      password: password,
      isValid: Formz.validate([user, password])
    );
  }
}


