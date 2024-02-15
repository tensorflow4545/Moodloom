class SignUP {
  String? email;
  String? password;
  UserDetailss? userDetails;

  SignUP({this.email, this.password, this.userDetails});

  SignUP.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    userDetails = json['userDetails'] != null
        ? new UserDetailss.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetailss {
  String? userId;
  String? name;
  String? age;
  String? phoneno;

  UserDetailss({this.userId, this.name, this.age, this.phoneno});

  UserDetailss.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    age = json['age'];
    phoneno = json['phoneno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['phoneno'] = this.phoneno;
    return data;
  }
}
