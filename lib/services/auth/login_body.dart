class LoginBody {
  final String email;
  final String password;
  final String deviceId;

  LoginBody(
    this.email,
    this.password,
    this.deviceId,
  );

  Map<String, dynamic> bodyData() {
    return {
      "email": email,
      "password": password,
      "android_token": deviceId,
    };
  }
}
