class CommentModel {
  String? userName;
  String? userImg;
  String? message;
  String? time;
  String? date;
  int? timestamp;
  bool? viewComments;
  List<String>? likes;
  List<ReplyCommentModel>? replies;

  CommentModel(
      {this.userName,
        this.userImg,
        this.message,
        this.time,
        this.date,
        this.timestamp,
        this.replies,
        this.viewComments,
        this.likes});

  CommentModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImg = json['userImg'];
    message = json['message'];
    time = json['time'];
    date = json['date'];
    viewComments = json['viewComments'];
    timestamp = json['timestamp'];
    likes = json['likes'].cast<String>();
    if (json['replies'] != null) {
      replies = <ReplyCommentModel>[];
      json['replies'].forEach((v) {
        replies!.add(new ReplyCommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImg'] = this.userImg;
    data['message'] = this.message;
    data['time'] = this.time;
    data['date'] = this.date;
    data['viewComments'] = this.viewComments;
    data['timestamp'] = this.timestamp;
    data['likes'] = this.likes;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ReplyCommentModel {
  String? userName;
  String? userImg;
  String? message;
  String? time;
  String? date;
  bool? viewComments;
  int? timestamp;
  List<String>? likes;
  List<CommentModel>? replies;

  ReplyCommentModel(
      {this.userName,
        this.userImg,
        this.message,
        this.time,
        this.date,
        this.viewComments,
        this.timestamp,
        this.replies,
        this.likes});

  ReplyCommentModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImg = json['userImg'];
    message = json['message'];
    time = json['time'];
    date = json['date'];
    viewComments = json['viewComments'];
    timestamp = json['timestamp'];
    likes = json['likes'].cast<String>();
    if (json['replies'] != null) {
      replies = <CommentModel>[];
      json['replies'].forEach((v) {
        replies!.add(new CommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImg'] = this.userImg;
    data['message'] = this.message;
    data['time'] = this.time;
    data['viewComments'] = this.viewComments;
    data['date'] = this.date;
    data['timestamp'] = this.timestamp;
    data['likes'] = this.likes;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
