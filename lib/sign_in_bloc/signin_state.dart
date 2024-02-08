abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInValidState extends SignInState {}

class SignInInValidaState extends SignInState {}

class SignInErrorState extends SignInState {
  final String ErrorMsg;
  SignInErrorState(this.ErrorMsg);
}

class SignInLoadingState extends SignInState {}
