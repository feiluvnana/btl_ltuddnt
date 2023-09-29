import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignupEvent {
  const SignupEvent();
}

abstract class SignupState {
  const SignupState();
}

class SignupStep1State extends SignupState with EquatableMixin {
  final key = GlobalKey<FormState>();

  SignupStep1State();

  @override
  List<Object> get props => [];
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupStep1State()) {
    on<SignupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
