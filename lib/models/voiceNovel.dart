
import 'dart:convert';

VoiceNovel voiceNovelFromJson(String str) => VoiceNovel.fromJson(json.decode(str));

String voiceNovelToJson(VoiceNovel data) => json.encode(data.toJson());

class VoiceNovel {
    VoiceNovel({
        required this.id,
   required     this.title,
    required    this.videoId,
     required   this.createdAt,
    required    this.v,
    });

    String id;
    String title;
    String videoId;
    DateTime createdAt;
    int v;

    factory VoiceNovel.fromJson(Map<String, dynamic> json) => VoiceNovel(
        id: json["_id"],
        title: json["title"],
        videoId: json["videoId"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "videoId": videoId,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
