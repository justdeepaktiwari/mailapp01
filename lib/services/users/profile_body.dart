class ProfileBody {
  final String name;
  final String phone;
  final String password;

  ProfileBody({
    this.password = '',
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> bodyData() {
    if (password != '') {
      return {
        "name": name,
        "phone": phone,
        "password": password,
      };
    }
    return {
      "name": name,
      "phone": phone,
    };
  }
}
