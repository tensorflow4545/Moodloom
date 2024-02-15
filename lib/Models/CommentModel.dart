class CommentModel {
  List<Comments>? comments;

  CommentModel({this.comments});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? sId;
  String? userId;
  String? name;
  String? category;
  String? message;
  int? likeCount;
  int? iV;

  Comments(
      {this.sId,
      this.userId,
      this.name,
      this.category,
      this.message,
      this.likeCount,
      this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    category = json['category'];
    name = json['name'];
    message = json['message'];
    likeCount = json['likeCount'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['message'] = this.message;
    data['likeCount'] = this.likeCount;
    data['__v'] = this.iV;
    return data;
  }
}

class SendComment {
  String? message;
  Comment? comment;

  SendComment({this.message, this.comment});

  SendComment.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    comment =
        json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.comment != null) {
      data['comment'] = this.comment!.toJson();
    }
    return data;
  }
}

class Comment {
  String? userId;
  String? name;
  String? category;
  String? message;
  int? likeCount;
  String? sId;
  int? iV;

  Comment(
      {this.userId,
      this.name,
      this.category,
      this.message,
      this.likeCount,
      this.sId,
      this.iV});

  Comment.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    category = json['category'];
    message = json['message'];
    likeCount = json['likeCount'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['message'] = this.message;
    data['likeCount'] = this.likeCount;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
