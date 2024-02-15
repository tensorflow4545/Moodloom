class AllCounselors {
  String? cabin;
  String? email;
  String? id;
  String? language;
  String? name;
  String? position;
  String? imageUrl;

  AllCounselors(
      {this.cabin,
      this.email,
      this.id,
      this.language,
      this.name,
      this.position,
      this.imageUrl});

  AllCounselors.fromJson(Map<String, dynamic> json) {
    cabin = json['cabin'];
    email = json['email'];
    id = json['id'];
    language = json['language'];
    name = json['name'];
    position = json['position'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cabin'] = this.cabin;
    data['email'] = this.email;
    data['id'] = this.id;
    data['language'] = this.language;
    data['name'] = this.name;
    data['position'] = this.position;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
