class NewsModel {
  String? channelId;
  String? channelImg;
  String? channelName;
  String? description;
  String? category;
  String? id;
  String? location;
  String? title;
  num? timestamp;
  List<String>? imgs;
  List<String>? likes;

  NewsModel(
      {this.channelId,
        this.channelImg,
        this.channelName,
        this.description,
        this.category,
        this.id,
        this.location,
        this.likes,
        this.title,
        this.timestamp,
        this.imgs});

  NewsModel.fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    channelImg = json['channelImg'];
    channelName = json['channelName'];
    description = json['description'];
    category = json['category'];
    id = json['id'];
    location = json['location'];
    title = json['title'];
    timestamp = json['timestamp'];
    imgs = json['imgs'].cast<String>();
    likes = json['likes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelId'] = this.channelId;
    data['channelImg'] = this.channelImg;
    data['channelName'] = this.channelName;
    data['description'] = this.description;
    data['category'] = this.category;
    data['id'] = this.id;
    data['location'] = this.location;
    data['title'] = this.title;
    data['timestamp'] = this.timestamp;
    data['imgs'] = this.imgs;
    data['likes'] = this.likes;
    return data;
  }
}
