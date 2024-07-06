
abstract class RegistrationEvent {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class RegistrationSubmitted extends RegistrationEvent {
  final String name;
  final String email;
  final String password;

  const RegistrationSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
