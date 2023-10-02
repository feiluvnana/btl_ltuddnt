import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'signup_bloc.freezed.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupNameChange extends SignupEvent {
  final String? firstName, lastName;

  const SignupNameChange({this.firstName, this.lastName});

  @override
  List<Object?> get props => [firstName, lastName];
}

class SignupDobChange extends SignupEvent {
  final DateTime dob;
  const SignupDobChange({required this.dob});

  @override
  List<Object?> get props => [dob];
}

class SignupEmailChange extends SignupEvent {
  final String? email;
  const SignupEmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class SignupPasswordChange extends SignupEvent {
  final String? password;
  const SignupPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class SignupSaveInfoChange extends SignupEvent {
  final bool saveInfo;
  const SignupSaveInfoChange({required this.saveInfo});

  @override
  List<Object?> get props => [saveInfo];
}

@freezed
class SignupState with _$SignupState {
  const factory SignupState(
      {@Default("") String firstName,
      @Default("") String lastName,
      required DateTime dob,
      @Default("") String email,
      @Default("") String password,
      @Default(false) bool saveInfo}) = _SignupState;
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState(dob: DateTime.now())) {
    on<SignupNameChange>((event, emit) {
      emit(state.copyWith(
          firstName: event.firstName ?? state.firstName,
          lastName: event.lastName ?? state.lastName));
    });
    on<SignupDobChange>((event, emit) {
      emit(state.copyWith(dob: event.dob));
    });
    on<SignupEmailChange>((event, emit) {
      emit(state.copyWith(email: event.email ?? state.email));
    });
    on<SignupPasswordChange>((event, emit) {
      emit(state.copyWith(password: event.password ?? state.password));
    });
    on<SignupSaveInfoChange>((event, emit) {
      emit(state.copyWith(saveInfo: event.saveInfo));
    });
  }
}
