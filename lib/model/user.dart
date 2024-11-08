import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? buyerId;
  String fullName;
  String? password;
  String email;
  String? phoneNumber;
  String photo;
  UserModel({
    this.buyerId,
    required this.fullName,
    this.password,
    required this.email,
    this.phoneNumber,
    required this.photo,
  });

  UserModel copyWith({
    String? buyerId,
    String? fullName,
    String? password,
    String? email,
    String? phoneNumber,
    String? photo,
  }) {
    return UserModel(
      buyerId: buyerId ?? this.buyerId,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buyerId': buyerId,
      'fullName': fullName,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'photo': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      buyerId: map['buyerId'] != null ? map['buyerId'] as String : null,
      fullName: map['fullName'] as String,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] as String,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(buyerId: $buyerId, fullName: $fullName, password: $password, email: $email, phoneNumber: $phoneNumber, photo: $photo)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.buyerId == buyerId &&
        other.fullName == fullName &&
        other.password == password &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return buyerId.hashCode ^
        fullName.hashCode ^
        password.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        photo.hashCode;
  }
}
