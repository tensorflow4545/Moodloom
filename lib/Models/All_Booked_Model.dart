class AllBookedSessions {
  List<AllBookSessions>? allBookSessions;

  AllBookedSessions({this.allBookSessions});

  AllBookedSessions.fromJson(Map<String, dynamic> json) {
    if (json['allBookSessions'] != null) {
      allBookSessions = <AllBookSessions>[];
      json['allBookSessions'].forEach((v) {
        allBookSessions!.add(new AllBookSessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allBookSessions != null) {
      data['allBookSessions'] =
          this.allBookSessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllBookSessions {
  String? sId;
  String? doctorId;
  String? userId;
  String? doctorName;
  String? time;
  String? date;
  int? iV;

  AllBookSessions(
      {this.sId,
      this.doctorId,
      this.userId,
      this.doctorName,
      this.time,
      this.date,
      this.iV});

  AllBookSessions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    doctorId = json['doctorId'];
    userId = json['userId'];
    doctorName = json['doctorName'];
    time = json['time'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['doctorId'] = this.doctorId;
    data['userId'] = this.userId;
    data['doctorName'] = this.doctorName;
    data['time'] = this.time;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
