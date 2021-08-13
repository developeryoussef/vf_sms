
import 'dart:convert';

Novel novelFromJson(String str) => Novel.fromJson(json.decode(str));

String novelToJson(Novel data) => json.encode(data.toJson());

class Novel {
    Novel({
      required  this.phrases,
    required    this.id,
     required   this.title,
    required    this.category,
     required   this.fullText,
      required  this.createdAt,
      required  this.v,
    });

    List<String> phrases;
    String id;
    String title;
    String category;
    String fullText;
    DateTime createdAt;
    int v;

    factory Novel.fromJson(Map<String, dynamic> json) => Novel(
        phrases: List<String>.from(json["phrases"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        category: json["category"],
        fullText: json["fullText"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "phrases": List<dynamic>.from(phrases.map((x) => x)),
        "_id": id,
        "title": title,
        "category": category,
        "fullText": fullText,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
