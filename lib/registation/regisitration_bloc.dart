// registration_bloc.dart
import 'package:ecommerse/registation/regisitration_event.dart';
import 'package:ecommerse/registation/regisitration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/registration_model.dart';
import '../services/sync_manager.dart';


class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
  }

  Future<void> _onRegistrationSubmitted(
      RegistrationSubmitted event,
      Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());

    try {
      final registration = RegistrationModel(
        name: event.name,
        email: event.email,
        password: event.password,
        avatar: "https://i.imgur.com/yhW6Yw1.jpg",
      );

      final result = await SyncManager.register(registration);

      if (result.isSuccess) {
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFailure(error: result.errorMsg ?? 'Unknown error'));
      }
    } catch (e) {
      emit(RegistrationFailure(error: e.toString()));
    }
  }
}
