class User {
  String id;
  String mobile;
  bool isVerified;
  bool delFlag;
  String status;
  List<String> refreshToken;
  String userId;
  String createdAt;
  String updatedAt;
  int v;
  String email;
  String firstName;
  String lastName;

  User({
    required this.id,
    required this.mobile,
    required this.isVerified,
    required this.delFlag,
    required this.status,
    required this.refreshToken,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        mobile: json["mobile"],
        isVerified: json["isVerified"],
        delFlag: json["delFlag"],
        status: json["status"],
        refreshToken: List<String>.from(json["refreshToken"].map((x) => x)),
        userId: json["userId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );
}
