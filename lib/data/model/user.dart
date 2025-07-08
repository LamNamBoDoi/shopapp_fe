class User {
  int? id;
  String? fullname;
  String? phoneNumber;
  String? address;
  String? password;
  String? retypePassword;
  String? dob;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? faceAccId;
  int? ggAccId;
  int? roleId;
  bool? isActive;
  String? thumbnail;

  // Constructor
  User(
      {this.id,
      this.fullname,
      this.phoneNumber,
      this.address,
      this.password,
      this.dob,
      this.retypePassword,
      this.createdAt,
      this.updatedAt,
      this.faceAccId,
      this.ggAccId,
      this.roleId,
      this.isActive,
      this.thumbnail});

  // toJson: Chuyển đổi đối tượng thành Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'phone_number': phoneNumber,
      'address': address,
      'password': password,
      'date_of_birth': dob,
      'retype_password': retypePassword,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'facebook_account_id': faceAccId,
      'google_account_id': ggAccId,
      'role_id': roleId,
      'is_active': isActive,
      "thumbnail": thumbnail,
    };
  }

  // fromJson: Tạo đối tượng từ Map (JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        fullname: json['fullname'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        retypePassword: json['retype_password'],
        password: json['password'],
        dob: json['date_of_birth'],
        // createdAt: json['created_at'],
        // updatedAt: json['updated_at'],
        faceAccId: json['facebook_account_id'],
        ggAccId: json['google_account_id'],
        roleId: json['role_id'],
        isActive: json['is_active'],
        thumbnail: json['thumbnail']);
  }
}
