class User {
  String? fullname;
  String? phoneNumber;
  String? address;
  String? password;
  String? dob;
  String? createdAt;
  String? updatedAt;
  int? faceAccId;
  int? ggAccId;
  int? roleId;
  bool? isActive;

  // Constructor
  User({
    this.fullname,
    this.phoneNumber,
    this.address,
    this.password,
    this.dob,
    this.createdAt,
    this.updatedAt,
    this.faceAccId,
    this.ggAccId,
    this.roleId,
    this.isActive,
  });

  // toJson: Chuyển đổi đối tượng thành Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'phone_number': phoneNumber,
      'address': address,
      'password': password,
      'date_of_birth': dob,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'facebook_account_id': faceAccId,
      'google_account_id': ggAccId,
      'role_id': roleId,
      'is_active': isActive,
    };
  }

  // fromJson: Tạo đối tượng từ Map (JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['fullname'],
      phoneNumber: json['phone_pumber'],
      address: json['address'],
      password: json['password'],
      dob: json['date_of_birth'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      faceAccId: json['facebook_account_id'],
      ggAccId: json['google_account_id'],
      roleId: json['role_id'],
      isActive: json['is_active'],
    );
  }
}
