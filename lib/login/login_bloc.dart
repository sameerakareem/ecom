import 'package:flutter_bloc/flutter_bloc.dart';
import 'AuthRepository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final user = await authRepository.getSavedRegistrationModel();
      if (user != null &&
          user.name == event.username &&
          user.password == event.password) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Incorrect username or password'));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
