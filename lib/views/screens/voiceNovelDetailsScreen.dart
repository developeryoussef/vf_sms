import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/constants.dart';

import 'package:rewayat_alkateb_islam/models/voiceNovel.dart';
import 'package:rewayat_alkateb_islam/repositories/PointsRepo.dart';
import 'package:rewayat_alkateb_islam/repositories/pricesRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VoiceDetails extends StatefulWidget {
  final VoiceNovel voiceNovel;
  const VoiceDetails({required this.voiceNovel});

  @override
  _VoiceDetailsState createState() => _VoiceDetailsState();
}

class _VoiceDetailsState extends State<VoiceDetails> {
  late YoutubePlayerController _controller;
  late BannerAd _bannerAd;
  final AdSize adSize = AdSize(height: 400, width: 450);
  late BannerAd _bannerAd2;
  late Timer timer;
  initAds() async {
    _bannerAd2 = BannerAd(
      adUnitId: bannerAdUnit,
      request: AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(),
    );
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnit4,
      request: AdRequest(),
      size: adSize,
      listener: BannerAdListener(),
    );

    _bannerAd.load();
    _bannerAd2.load();
  }

  @override
  void initState() {
    initAds();
    timer = Timer.periodic(Duration(seconds: 15), (t) async {
 PointsRepo().increaseFromVideoWatching();
    });

    _controller = YoutubePlayerController(
      initialVideoId: widget.voiceNovel.videoId,
      params: YoutubePlayerParams(
        //       playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
        startAt: Duration(seconds: 0),
        showControls: true, autoPlay: true,

        showFullscreenButton: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _bannerAd2.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          widget.voiceNovel.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontFamily: 'Cairo',
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                child: YoutubePlayerIFrame(
                  controller: _controller,
                  aspectRatio: 16 / 9,
                ),
              ),
              Container(
                  height: _bannerAd.size.height.toDouble(),
                  width: _bannerAd.size.width.toDouble(),
                  child: AdWidget(
                    ad: _bannerAd,
                  ))
            ],
          ),
          Positioned(
            child: Container(
              height: _bannerAd2.size.height.toDouble(),
              width: _bannerAd2.size.width.toDouble(),
              child: AdWidget(
                ad: _bannerAd2,
              ),
            ),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
