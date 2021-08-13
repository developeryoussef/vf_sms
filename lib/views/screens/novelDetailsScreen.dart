import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/constants.dart';

import 'package:rewayat_alkateb_islam/models/novel.dart';
import 'package:rewayat_alkateb_islam/repositories/PointsRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovelDetailsScreen extends StatefulWidget {
  final Novel novel;
  final String categoryAr;
  const NovelDetailsScreen({required this.novel, required this.categoryAr});

  @override
  _NovelDetailsScreenState createState() => _NovelDetailsScreenState();
}

class _NovelDetailsScreenState extends State<NovelDetailsScreen> {
  Color mainColor = kMainColor;
  Color bckgColor = Colors.white;
  Color textColor = Colors.black;
  bool isDark = false;
  ScrollController scrollController = ScrollController();

  // TODO: Add _rewardedAd
  late RewardedAd _rewardedAd;

  // TODO: Add _isRewardedAdReady
  bool _isRewardedAdReady = false;

  // TODO: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnit,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    _loadRewardedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
                if (isDark == true) {
                  bckgColor = Color(0xff393E46);
                  mainColor = Color(0xff222831);
                  textColor = Color(0xFFEEEEEE);
                } else {
                  mainColor = kMainColor;
                  bckgColor = Colors.white;
                  textColor = Colors.black;
                }
              },
              icon: Icon(
                isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
                color: Colors.white,
              ))
        ],
        iconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
        title: Text(
          widget.novel.title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      body: Container(
        height: _height,
        color: bckgColor,
        width: _width,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ScrollWrapper(
              promptTheme: PromptButtonTheme(
                  color: isDark ? Color(0xffFFD369) : kMainColor),
              scrollController: scrollController,
              child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (xt, i) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.only(),
                    child: ListTile(
                      trailing: InkWell(
                        onTap: () async {
                          //TODO UNCOMMENT REWARDED AD
                          _rewardedAd.show(
                              onUserEarnedReward: (rewardAd, rwItem) async {
                            print(
                                "rw ad + ${rewardAd.responseInfo}  +++++ rw item + ${rwItem.amount} + ${rwItem.type}");
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            print(sharedPreferences.getDouble("PointsPerAd"));

                            await PointsRepo().increasePoints();
                  
                          });

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("novelName", widget.novel.title);
                          prefs.setString("categoryName", widget.categoryAr);
                          prefs.setInt("index", i);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 8),
                              content: Text(
                                "تم وضع العلامة",
                                style: TextStyle(color: Colors.white),
                              )));
                        },
                        child: Container(
                          width: _width * .1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    color: isDark ? bckgColor : Colors.white,
                                  ),
                                ),
                                Icon(
                                  Elusive.bookmark,
                                  color: isDark ? bckgColor : Colors.white,
                                  size: 28,
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: isDark ? Color(0xffFFD369) : kMainColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                        ),
                      ),
                      title: Text(
                        widget.novel.phrases[i],
                        style: TextStyle(
                          fontSize: 16, color: textColor,
                          fontWeight: FontWeight.bold,
                          //   color: Colors.black.withOpacity(.7),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                },
                itemCount: widget.novel.phrases.length,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
