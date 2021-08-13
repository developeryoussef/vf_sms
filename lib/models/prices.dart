import 'dart:convert';

Prices pricesFromJson(String str) => Prices.fromJson(json.decode(str));

String pricesToJson(Prices data) => json.encode(data.toJson());

class Prices {
  Prices({
    required this.pointsPerAd,
    required this.creditPriceFor1KPoints,this.pointsPerHour,
    required this.id,
  });

  dynamic pointsPerAd;
  dynamic creditPriceFor1KPoints; 
    dynamic pointsPerHour;

  String id;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        pointsPerAd: json["pointsPerAd"],
        creditPriceFor1KPoints: json["creditPriceFor1kPoints"],
        pointsPerHour:json["pointsPerHour"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "pointsPerAd": pointsPerAd,
        "creditPriceFor1kPoints": creditPriceFor1KPoints,
        "pointsPerHour":pointsPerHour,
        "_id": id,
      };
}
