class AllDoctorsModel {
  Doctor? doctor;

  AllDoctorsModel({this.doctor});

  AllDoctorsModel.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Doctor {
  String? sId;
  String? email;
  DoctorDetails? doctorDetails;
  int? iV;

  Doctor({this.sId, this.email, this.doctorDetails, this.iV});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    doctorDetails = json['doctorDetails'] != null
        ? new DoctorDetails.fromJson(json['doctorDetails'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    if (this.doctorDetails != null) {
      data['doctorDetails'] = this.doctorDetails!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class DoctorDetails {
  String? userId;
  String? name;
  String? age;
  String? phoneno;
  String? imageUrl;
  Address? address;
  String? sId;

  DoctorDetails(
      {this.userId,
      this.name,
      this.age,
      this.phoneno,
      this.imageUrl,
      this.address,
      this.sId});

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    age = json['age'];
    phoneno = json['phoneno'];
    imageUrl = json['imageUrl'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['phoneno'] = this.phoneno;
    data['imageUrl'] = this.imageUrl;
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
    state = json['state'];
    country = json['country'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['_id'] = this.sId;
    return data;
  }
}
