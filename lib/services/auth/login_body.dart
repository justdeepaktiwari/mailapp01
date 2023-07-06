class LoginBody {
  final String email;
  final String password;

  LoginBody(
    this.email,
    this.password,
  );

  Map<String, dynamic> bodyData() {
    return {
      "email": email,
      "password": password,
    };
  }
}
