import 'dart:convert';

import 'package:HappyLink/Models/All_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  User? user;

  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? password;
  UserDetails? userDetails;
  int? iV;

  User({this.sId, this.email, this.userDetails, this.password, this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class UserDetails {
  String? userId;
  String? name;
  String? age;
  String? phoneno;
  Address? address;
  String? imageurl;
  String? sId;

  UserDetails(
      {this.userId,
      this.name,
      this.age,
      this.phoneno,
      this.address,
      this.imageurl,
      this.sId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    age = json['Age'];
    phoneno = json['phoneno'];
    imageurl = json["imageUrl"];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['Age'] = this.age;
    data['phoneno'] = this.phoneno;
    data['imageUrl'] = this.imageurl;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Address {
  String? city;
  String? state;
  String? country;
  String? sId;

  Address({this.city, this.state, this.country, this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['State'];
    country = json['country'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['State'] = this.state;
    data['country'] = this.country;
    data['_id'] = this.sId;
    return data;
  }
}

class Statuss {
  final String status;
  final String token;

  Statuss({required this.status, required this.token});

  factory Statuss.fromJson(Map<String, dynamic> json) {
    return Statuss(
      status: json['status'] ?? '',
      token: json['token'] ?? '',
    );
  }
}

Future<String> getStoredCredentials(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(key) ?? '';
  return token;
}

Future<void> storeCredentials(String key, var data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);
}

Future<void> storeBoolCredentials(String key, bool data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, data);
}

Future<void> deleteFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> saveDataLocally(List<Data> data) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = data.map((item) => item.toJson()).toList();
  final jsonString = json.encode(jsonData);
  await prefs.setString('alluserdata', jsonString);
}

Future<List<Data>> loadDataLocally() async {
  final prefs = await SharedPreferences.getInstance();
  final storedData = prefs.getString('alluserdata');
  if (storedData != null) {
    final jsonData = json.decode(storedData) as List;
    return jsonData.map((item) => Data.fromJson(item)).toList();
  } else {
    return [];
  }
}
