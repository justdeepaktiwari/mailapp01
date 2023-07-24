class ResetPasswordBody {
  final String code;
  final String password;
  final String phoneNumber;

  ResetPasswordBody(
    this.code,
    this.phoneNumber,
    this.password,
  );

  Map<String, dynamic> bodyData() {
    return {
      "phone_number": phoneNumber,
      "verification_code": code,
      "password": password,
    };
  }
}
