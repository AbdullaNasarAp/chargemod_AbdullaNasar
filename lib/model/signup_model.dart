class SignUpModel {
  final String? phone;

  SignUpModel({
    required this.phone,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
    };
  }
}
