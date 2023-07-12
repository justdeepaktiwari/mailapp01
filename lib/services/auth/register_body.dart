class RegisterBody {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;
  final String deviceId;

  RegisterBody(
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.passwordConfirmation,
    this.deviceId,
  );

  Map<String, dynamic> bodyData() {
    return {
      "name": name,
      "email": email,
      "phone": phoneNumber,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "android_token": deviceId,
    };
  }
}
