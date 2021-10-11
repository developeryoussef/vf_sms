import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/messages_bloc.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/user_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/repositories/PointsRepo.dart';
import 'package:rewayat_alkateb_islam/repositories/pricesRepo.dart';
import 'package:rewayat_alkateb_islam/views/screens/authScreen.dart';
import 'package:rewayat_alkateb_islam/views/screens/chatScreen.dart';
import 'package:rewayat_alkateb_islam/views/screens/userPage.dart';
import 'package:rewayat_alkateb_islam/views/screens/videoPage.dart';
import 'package:rewayat_alkateb_islam/views/widgets/categoryContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {   

  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  InterstitialAd? _interstitialAd;

  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnit,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void initState() {
    _loadInterstitialAd();
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnit,
      request: AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
          _bannerAd = BannerAd(
            adUnitId: bannerAdUnit2,
            request: AdRequest(),
            size: AdSize.fullBanner,
            listener: BannerAdListener(
              onAdLoaded: (_) {
                setState(() {
                  _isBannerAdReady = true;
                });
              },
              onAdFailedToLoad: (ad, err) {
                print('Failed to load a banner ad: ${err.message}');
                _isBannerAdReady = false;
                ad.dispose();
              },
            ),
          );
        },
      ),
    );

    _bannerAd.load();
    PricesRepo().getPrices();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: kMainColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => BlocProvider(
                                create: (context) =>
                                    UserBloc()..add(FetchUser()),
                                child: UserPage(),
                              )));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => BlocProvider(
                              create: (context) => UserBloc()..add(FetchUser()),
                              child: UserPage(),
                            )));
              },
              child: CircleAvatar(
                backgroundColor: Colors.amber[700],
                child: Center(
                  child: Icon(
                    FontAwesome.dollar,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            "الصفحة الرئيسية",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'Cairo',
                fontSize: 18),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                AssetImage("assets/images/logo.jpg"),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          IconButton(
                              onPressed: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.getString("novelName") == null
                                        ? showDialog(
                                            context: context,
                                            builder: (ctx) => Dialog(
                                                  backgroundColor: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: _width * .7,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'لا توجد علامات',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Cairo'),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                        : showAnimatedDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child:
                                                    ClassicGeneralDialogWidget(
                                                  titleText: 'العلامة',
                                                  contentText:
                                                      'انت متوقق عند الرواية ${sharedPreferences.getString("novelName")} التي توجد في فئة ${sharedPreferences.getString("categoryName")} فقرة رقم ${sharedPreferences.getInt("index")}',
                                                  onPositiveClick: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  positiveText: "حسنا",
                                                ),
                                              );
                                            },
                                            animationType:
                                                DialogTransitionType.size,
                                            curve: Curves.fastOutSlowIn,
                                            duration:
                                                Duration(milliseconds: 450),
                                          ) /*showDialog(
                                        context: context,
                                        builder: (ctx) => Dialog(
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: _width * .7,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'انت متوقق عند الرواية ${sharedPreferences.getString("novelName")} التي توجد في فئة ${sharedPreferences.getString("categoryName")} فقرة رقم ${sharedPreferences.getInt("index")}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Cairo'),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))*/
                                    ;
                              },
                              icon: Icon(
                                Icons.bookmarks,
                                color: Colors.white,
                                size: 32,
                              ))
                        ],
                      ),
                    ),
                    height: _height * .175,
                    decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),
                  SizedBox(
                    height: _height * .01,
                  ),
                  Container(
                    height: _height * .44,
                    width: _width,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.5 / 1.3),
                      children: [
                        buildCatContainer(
                            context,
                            _height,
                            _width,
                            "romantic",
                            "روايات رومانسية",
                            "assets/images/romantic.png",
                            "romancy",
                            "رومانسي", () {
                          _interstitialAd?.show();
                        }, () {
                          _interstitialAd!.dispose();
                        }),
                        buildCatContainer(
                            context,
                            _height,
                            _width,
                            "dramatic",
                            "روايات درامية",
                            "assets/images/dramatic.png",
                            "drama",
                            "درامي", () {
                          _interstitialAd?.show();
                        }, () {
                          _interstitialAd!.dispose();
                        }),
                
                        buildCatContainer(
                            context,
                            _height,
                            _width,
                            "followers",
                            "روايات المتابعين",
                            "assets/images/followers.png",
                            "motab3en",
                            "متابعين", () {
                          _interstitialAd?.show();
                        }, () {
                          _interstitialAd!.dispose();
                        }),
                        buildCatContainer(
                            context,
                            _height,
                            _width,
                            "horror",
                            "روايات رعب",
                            "assets/images/horror.jpg",
                            "ro3b",
                            "رعب", () {
                          _interstitialAd?.show();
                        }, () {
                          _interstitialAd!.dispose();
                        }),
                    /*    buildCatContainer(
                            context,
                            _height,
                            _width,
                            "voiceNovels",
                            "روايات صوتيه",
                            "assets/images/voice.png",
                            "sawty",
                            "صوتي", () {
                          _interstitialAd?.show();
                        }, () {
                          _interstitialAd!.dispose();
                        }),*/
                   
                      ],
                    ),
                  ),
        
                      buildContainer(
                            context,
                            _height,
                            _width,
                            "",
                            "حللي مشكلتي",
                            "assets/images/myProblem.png",
                            "moshkela", () async {
                          PointsRepo().decreaseForSolveMyProblem(context);
                        }),
                ],
              ),
            ),
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ));
  }
}
