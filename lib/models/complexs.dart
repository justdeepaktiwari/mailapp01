class ComplexList {
  final int id;
  final String name;
  final String email;
  final String code;

  ComplexList({
    required this.id,
    required this.name,
    required this.email,
    required this.code,
  });

  factory ComplexList.fromMap(Map<String, dynamic> apiData) {
    return ComplexList(
      id: apiData["id"],
      name: apiData["name"],
      email: apiData["email"],
      code: apiData["code"],
    );
  }
}
