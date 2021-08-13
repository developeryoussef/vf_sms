import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/novels_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/views/screens/novelDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shimmer/shimmer.dart';

class CategoryNovels extends StatefulWidget {
  final nameAr;
  final nameEn;
  final tag;
  final photoPath;
  final nameAr2;
  final forDisposing;
  const CategoryNovels(
      {this.nameAr,
      this.nameEn,
      this.tag,
      this.photoPath,
      this.nameAr2,
      this.forDisposing});

  @override
  _CategoryNovelsState createState() => _CategoryNovelsState();
}

class _CategoryNovelsState extends State<CategoryNovels> {
  // TODO: Add _bannerAd
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;
  bool _isBannerAd2Ready = false;

  final BannerAd myBanner = BannerAd(
    adUnitId: bannerAdUnit,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

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

  late AdWidget adWidget;

  @override
  void initState() {
    _loadRewardedAd();
    //_loadInterstitialAd();
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
        },
      ),
    );
    _bannerAd2 = BannerAd(
      adUnitId: bannerAdUnit4,
      request: AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAd2Ready = true;
            adWidget = AdWidget(ad: this._bannerAd2);
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAd2Ready = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    _bannerAd2.load();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    widget.forDisposing();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: _width,
            height: _height,
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: _height * .05,
                        ),
                        Hero(
                          tag: widget.tag,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(widget.photoPath),
                          ),
                        ),
                        SizedBox(
                          height: _height * .01,
                        ),
                        Text(
                          widget.nameAr,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Cairo',
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  height: _height * .23,
                  decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                ),
                Expanded(child: BlocBuilder<NovelsBloc, NovelsState>(
                  builder: (context, state) {
                    if (state is NovelsLoading) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(.5),
                        highlightColor: Colors.white,
                        direction: ShimmerDirection.rtl,
                        period: Duration(seconds: 1),
                        enabled: true,
                        child: ListView.builder(
                            itemCount: 7,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  width: _width,
                                  height: _height * .08,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else if (state is NovelsLoaded) {
                      return AnimationLimiter(
                        child: ListView.builder(
                            itemBuilder: (ctx, i) {
                              if (_isBannerAd2Ready == true && i == 0) {
                                return Container(
                                  width: _bannerAd2.size.width.toDouble(),
                                  height: _bannerAd2.size.height.toDouble(),
                                  child: AdWidget(ad: _bannerAd2),
                                );
                              } else if (_isBannerAd2Ready == false) {
                                return AnimationConfiguration.staggeredList(
                                  position: i - 1,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: OpenContainer(
                                          transitionType:
                                              ContainerTransitionType
                                                  .fadeThrough,
                                          closedBuilder: (ctx, c) {
                                            return GestureDetector(
                                              child: Container(
                                                width: _width,
                                                height: _height * .08,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Icon(
                                                      Icons.chevron_left,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Text(widget.nameAr2),
                                                    SizedBox(
                                                      width: _width * .14,
                                                    ),
                                                    Text(
                                                      state.novels[i].title,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Expanded(
                                                        child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    blurRadius:
                                                                        2)
                                                              ],
                                                              color:
                                                                  Colors.white),
                                                          height: 40,
                                                          width: 50,
                                                          child: Image.asset(
                                                              widget.photoPath),
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(.7),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 1))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              onTap: () async {
                                                 _rewardedAd.show(
                                                    onUserEarnedReward:
                                                        (rewardAd,
                                                            rwItem) async {
                                                
                                                });
                                      
                                                c();
                                              },
                                            );
                                          },
                                          openBuilder: (ctx, o) {
                                            return NovelDetailsScreen(
                                              novel: state.novels[i],
                                              categoryAr: widget.nameAr,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return AnimationConfiguration.staggeredList(
                                  position: i - 1,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: OpenContainer(
                                          transitionType:
                                              ContainerTransitionType
                                                  .fadeThrough,
                                          closedBuilder: (ctx, c) {
                                            return GestureDetector(
                                              child: Container(
                                                width: _width,
                                                height: _height * .08,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Icon(
                                                      Icons.chevron_left,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Text(widget.nameAr2),
                                                    SizedBox(
                                                      width: _width * .2,
                                                    ),
                                                    Text(
                                                      state.novels[(i - 1)]
                                                          .title,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Expanded(
                                                        child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    blurRadius:
                                                                        2)
                                                              ],
                                                              color:
                                                                  Colors.white),
                                                          height: 40,
                                                          width: 50,
                                                          child: Image.asset(
                                                              widget.photoPath),
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(.7),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 1))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              onTap: () {
                                                _rewardedAd.show(
                                                    onUserEarnedReward: (c, p) {
                                                  print(p.amount);
                                                });

                                                c();
                                              },
                                            );
                                          },
                                          openBuilder: (ctx, o) {
                                            return NovelDetailsScreen(
                                              novel: state.novels[(i - 1)],
                                              categoryAr: widget.nameAr,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            itemCount: _isBannerAd2Ready
                                ? state.novels.length + 1
                                : state.novels.length),
                      );
                      /*    LiveList.options(
                              options: LiveOptions(
                                showItemDuration: Duration(milliseconds: 150),
                                showItemInterval: Duration(milliseconds: 150),
                              ),
                              itemBuilder: (ctx, i, anm) {
                                return FadeTransition(
                                  opacity:
                                      Tween<double>(begin: 0, end: 1).animate(anm),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                            begin: Offset(0, -.1), end: Offset.zero)
                                        .animate(anm),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: OpenContainer(
                                        transitionType:
                                            ContainerTransitionType.fadeThrough,
                                        closedBuilder: (ctx, c) {
                                          return GestureDetector(
                                            child: Container(
                                              width: _width,
                                              height: _height * .08,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Icon(
                                                    Icons.chevron_left,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Text(widget.nameAr2),
                                                  SizedBox(
                                                    width: _width * .2,
                                                  ),
                                                  Text(
                                                    state.novels[i].title,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Expanded(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color:
                                                                      Colors.grey,
                                                                  blurRadius: 2)
                                                            ],
                                                            color: Colors.white),
                                                        height: 40,
                                                        width: 50,
                                                        child: Image.asset(
                                                            widget.photoPath),
                                                      ),
                                                    ),
                                                  ))
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(.7),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 1))
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            onTap: c,
                                          );
                                        },
                                        openBuilder: (ctx, o) {
                                          return NovelDetailsScreen(
                                            novel: state.novels[i],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.novels.length);
           */
                    }

                    return Container();
                  },
                ))
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
      ),
    );
  }
}
