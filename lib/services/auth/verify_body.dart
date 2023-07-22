class VerifyBody {
  final String email;
  final String password;
  final String deviceId;

  VerifyBody(
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
