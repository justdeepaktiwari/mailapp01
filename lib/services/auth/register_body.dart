class RegisterBody {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  RegisterBody(
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.passwordConfirmation,
  );

  Map<String, dynamic> bodyData() {
    return {
      "name": name,
      "email": email,
      "phone": phoneNumber,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}
