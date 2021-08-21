import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/voicenovels_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/views/screens/voiceNovelDetailsScreen.dart';

import 'package:shimmer/shimmer.dart';

class VoiceNovels extends StatefulWidget {
  final tag;
  final photoPath;
  final nameAr;
  final nameEn;
  final nameAr2;
  const VoiceNovels(
      {this.tag, this.photoPath, this.nameAr, this.nameEn, this.nameAr2});

  @override
  _VoiceNovelsState createState() => _VoiceNovelsState();
}

class _VoiceNovelsState extends State<VoiceNovels> {
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
          RewardedAd.load(
            adUnitId: "ca-app-pub-4985704153931149/2251136235",
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
        },
      ),
    );
  }

  late AdWidget adWidget;

  @override
  void initState() {
 // FirebaseAuth.instance.signOut();
    _loadRewardedAd();
    //_loadInterstitialAd();
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
    _bannerAd2 = BannerAd(
      adUnitId: bannerAdUnit3,
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
    _bannerAd2.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
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
              Expanded(child: BlocBuilder<VoicenovelsBloc, VoicenovelsState>(
                builder: (context, state) {
                  if (state is VoiceLoading) {
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
                  } else if (state is VoiceLoaded) {
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
                                                    state.voiceNovels[i].title,
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
                                                          const EdgeInsets.only(
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
                                                                  blurRadius: 2)
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
                                            onTap: c,
                                          );
                                        },
                                        openBuilder: (ctx, o) {
                                          return VoiceDetails(
                                                  voiceNovel: state.voiceNovels[
                                                      i]) /*NovelDetailsScreen(
                                            novel: state.novels[i],
                                          )*/
                                              ;
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
                                                    state.voiceNovels[i - 1]
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
                                                          const EdgeInsets.only(
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
                                                                  blurRadius: 2)
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
                                            onTap: c,
                                          );
                                        },
                                        openBuilder: (ctx, o) {
                                          return VoiceDetails(
                                                  voiceNovel: state.voiceNovels[i -
                                                      1]) /*NovelDetailsScreen(
                                            novel: state.novels[i],
                                          )*/
                                              ;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          itemCount: _isBannerAd2Ready
                              ? state.voiceNovels.length + 1
                              : state.voiceNovels.length),
                    );
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
              color: Colors.white,
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ),
      ],
    ));
  }
}
/*   YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'K18cpp_-gP8',
      params: YoutubePlayerParams(
        //       playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
        startAt: Duration(seconds: 0),
        showControls: true, autoPlay: true,

        showFullscreenButton: true,
      ),
    );
YoutubePlayerIFrame(
        controller: _controller,
        aspectRatio: 16 / 9,
      )

*/ 