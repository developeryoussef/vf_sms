// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class MessageModel {
  String? id;
  String? messageText;
  String? messageSender;

  MessageModel({
    this.id,
    this.messageText,
    this.messageSender,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    messageText = json['message'];
    messageSender = json['senderAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['message'] = this.messageText;
    data['senderAddress'] = this.messageSender;
    return data;
  }
}
