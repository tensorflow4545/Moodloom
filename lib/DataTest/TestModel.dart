class WeeklyAppointment {
  String? day;
  String? counselorId;
  List<Allslots>? allslots;

  WeeklyAppointment({this.day, this.counselorId, this.allslots});

  WeeklyAppointment.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    counselorId = json['CounselorId'];
    if (json['allslots'] != null) {
      allslots = <Allslots>[];
      json['allslots'].forEach((v) {
        allslots!.add(new Allslots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['CounselorId'] = this.counselorId;
    if (this.allslots != null) {
      data['allslots'] = this.allslots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allslots {
  String? startTime;
  String? endTime;
  String? name;
  String? patientId;
  String? counselorId;
  String? fromDate;
  String? toDate;
  String? description;
  String? regdNo;
  bool? isBooked;
  bool? isDeleted;

  Allslots(
      {this.startTime,
      this.endTime,
      this.name,
      this.patientId,
      this.counselorId,
      this.fromDate,
      this.toDate,
      this.description,
      this.regdNo,
      this.isBooked,
      this.isDeleted});

  Allslots.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    name = json['name'];
    patientId = json['patientId'];
    counselorId = json['counselorId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    description = json['description'];
    regdNo = json['regdNo'];
    isBooked = json['isBooked'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['name'] = this.name;
    data['patientId'] = this.patientId;
    data['counselorId'] = this.counselorId;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['description'] = this.description;
    data['regdNo'] = this.regdNo;
    data['isBooked'] = this.isBooked;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
