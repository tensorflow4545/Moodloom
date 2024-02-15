class SessionsModel {
  List<Session> session;

  SessionsModel({required this.session});

  factory SessionsModel.fromJson(Map<String, dynamic> json) {
    var sessionList = json['session'] as List;
    List<Session> sessions = sessionList
        .map((sessionJson) => Session.fromJson(sessionJson))
        .toList();

    return SessionsModel(session: sessions);
  }
}

class Session {
  String id;
  String userId;
  String doctorname;
  String date;
  String time;
  int v;

  Session({
    required this.id,
    required this.userId,
    required this.doctorname,
    required this.date,
    required this.time,
    required this.v,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['_id'],
      userId: json['userId'],
      doctorname: json['doctorname'],
      date: json['date'],
      time: json['time'],
      v: json['__v'],
    );
  }
}
