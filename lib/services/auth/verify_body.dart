class VerifyBody {
  final String code;
  final String phoneNumber;

  VerifyBody(
    this.code,
    this.phoneNumber,
  );

  Map<String, dynamic> bodyData() {
    return {
      "phone_number": phoneNumber,
      "verification_code": code,
    };
  }
}
