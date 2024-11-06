class UserModel {
  int id;
  String? username;
  Name name;
  String password;
  String email;
  String phone;
  Address? address;
  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    this.address,
    this.username='abdelhaliem67',
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      id: json['id'],
      address: Address(
        geolocation: Geolocation(
          lang: json['address']['geolocation']['long'],
          lat: json['address']['geolocation']['lat'],
        ),
        city: json['address']['city'],
        zipcode: json['address']['zipcode'],
        street: json['address']['street'],
      ),
      name: Name(
          firstName: json['name']['firstname'],
          lastName: json['name']['lastname']),
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }
}

class Name {
  String firstName;
  String lastName;
  Name({
    required this.firstName,
    required this.lastName,
  });
}

class Address {
  String? city;
  String? street;
  String? zipcode;
  Geolocation? geolocation;
  Address({
    this.city,
    this.street,
    this.zipcode,
    this.geolocation,
  });
}

class Geolocation {
  String? lat;
  String? lang;
  Geolocation({
    this.lat,
    this.lang,
  });
}
