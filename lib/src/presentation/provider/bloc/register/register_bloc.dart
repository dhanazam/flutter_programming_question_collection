import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:validations/form_inputs.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterNameChanged>(_onRegisterNameChanged);
    on<RegisterConfirmPasswordChanged>(_onRegisterConfirmPasswordChanged);

    on<RegisterEmailUnfocused>(_onRegisterEmailUnfocused);
    on<RegisterPasswordUnfocused>(_onRegisterPasswordUnfocused);
    on<RegisterNameUnfocused>(_onRegisterNameUnfocused);
    on<RegisterConfirmPasswordUnfocused>(_onRegisterConfirmPasswordUnfocused);

    on<RegisterFormSubmitted>(_onRegisterFormSubmitted);
  }

  Future<void> _onRegisterEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) async {
    final email = RegisterEmailField.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : RegisterEmailField.pure(event.email),
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          email,
          state.password,
          state.name,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> _onRegisterPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) async {
    final password = RegisterPasswordField.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid
            ? password
            : RegisterPasswordField.pure(event.password),
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          password,
          state.email,
          state.name,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> _onRegisterNameChanged(
      RegisterNameChanged event, Emitter<RegisterState> emit) async {
    final name = RegisterNameField.dirty(event.name);
    emit(
      state.copyWith(
        name: name.isValid ? name : RegisterNameField.pure(event.name),
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          name,
          state.email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> _onRegisterConfirmPasswordChanged(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) async {
    final confirmedPassword = RegisterConfirmedPasswordField.dirty(
      password: state.confirmedPassword.value,
      value: event.password,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          confirmedPassword,
          state.password,
          state.name,
          state.email,
        ]),
      ),
    );
  }

  Future<void> _onRegisterEmailUnfocused(
      RegisterEmailUnfocused event, Emitter<RegisterState> emit) async {
    final email = RegisterEmailField.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          email,
          state.password,
          state.name,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> _onRegisterPasswordUnfocused(
      RegisterPasswordUnfocused event, Emitter<RegisterState> emit) async {
    final password = RegisterPasswordField.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          password,
          state.email,
          state.name,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> _onRegisterNameUnfocused(
      RegisterNameUnfocused event, Emitter<RegisterState> emit) async {
    final name = RegisterNameField.dirty(state.name.value);
    emit(
      state.copyWith(
        name: name,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          name,
          state.email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> _onRegisterConfirmPasswordUnfocused(
      RegisterConfirmPasswordUnfocused event,
      Emitter<RegisterState> emit) async {
    final confirmedPassword = RegisterConfirmedPasswordField.dirty(
        password: state.password.value, value: state.confirmedPassword.value);
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          confirmedPassword,
          state.email,
          state.password,
          state.name,
        ]),
      ),
    );
  }

  Future<void> _onRegisterFormSubmitted(
      RegisterFormSubmitted event, Emitter<RegisterState> emit) async {
    final email = RegisterEmailField.dirty(state.email.value);
    final password = RegisterPasswordField.dirty(state.password.value);
    final name = RegisterNameField.dirty(state.name.value);
    final confirmPassword = RegisterConfirmedPasswordField.dirty(
        password: state.password.value, value: state.confirmedPassword.value);
    emit(
      state.copyWith(
        email: email,
        password: password,
        name: name,
        confirmedPassword: confirmPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([email, password, name, confirmPassword]),
      ),
    );
    if (state.isValid) {
      User user = User(
        email: state.email.value.toString(),
        password: state.password.value.toString(),
        displayName: state.name.value.toString(),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUp(user);

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on firebase_auth.FirebaseAuthException catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          toastMessage: e.message.toString(),
        ));
      }
    }
  }
}
