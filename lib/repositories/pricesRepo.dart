import 'package:dio/dio.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/prices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PricesRepo {
    getPrices() async {
      late Prices prices;
      Response response =
          await Dio().get('$baseUrl/prices/610f075b693b473bc00ce644');
      prices = Prices.fromJson(response.data);

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setDouble("PointsPerAd", (prices.pointsPerAd).toDouble());
      sharedPreferences.setDouble(
          "creditPriceFor1kPoints", (prices.creditPriceFor1KPoints).toDouble());
      sharedPreferences.setDouble(
          "pointsPerHour", (prices.pointsPerHour).toDouble());
    }
}
