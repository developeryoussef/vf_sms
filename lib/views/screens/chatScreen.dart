import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/messages_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/messageRoom.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController _scrollController;
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;
  bool _isBannerAd2Ready = false;
  late Timer timer;
  late TextEditingController textEditingController;
  buildBottomContainer() {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 18, top: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * .067,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(35)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                textDirection: TextDirection.rtl,
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: 'ادخل رسالتك هنا', hintStyle: TextStyle()),
                style: TextStyle(
                    fontFamily: 'Cairo', fontSize: 18, letterSpacing: 1),
                cursorHeight: 20,
              ),
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.green,
              child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      BlocProvider.of<MessagesBloc>(context)
                          .add(SendMessage(textEditingController.text));
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      textEditingController.clear();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
late MessageRoom messageRoom;
  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnit4,
      request: AdRequest(),
      size: AdSize.banner,
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
    textEditingController = new TextEditingController();
    timer = Timer.periodic(Duration(seconds: 3), (t) {
      BlocProvider.of<MessagesBloc>(context).add(RefreshMessages(_scrollController,messageRoom));
    });
    _scrollController = new ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _bannerAd2.dispose();
    timer.cancel(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.green,
        title: Container(
            height: _bannerAd.size.height.toDouble(),
            width: _bannerAd.size.width.toDouble(),
            child: AdWidget(
              ad: _bannerAd,
            )),
      ),
      body: //  Stack(
          //  children: [
          ListView(
        children: [
          Container(
            height: _height * .72,
            color: Colors.white,
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MessagesFetched) {
                  messageRoom=state.messageRoom;
                  return ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: state.messageRoom.messages[i].userId ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? const EdgeInsets.only(right: 80.0)
                              : const EdgeInsets.only(left: 80.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              width: _width * .7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: state.messageRoom.messages[i].userId ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? Colors.green
                                      : Colors.cyan.withOpacity(.5)),
                              alignment: state.messageRoom.messages[i].userId ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10),
                                child: Text(
                                  state.messageRoom.messages[i].message,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: state.messageRoom.messages[i]
                                                  .userId ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.messageRoom.messages.length,
                  );
                } else if (state is MessagesEmpty) {
                  return Center(
                    child: Text('no messages'),
                  );
                }
                return Container();
              },
            ),
          ),
          buildBottomContainer(),
             if(_isBannerAd2Ready)
          Container(
              height: _bannerAd2.size.height.toDouble(),
              width: _bannerAd2.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd2)),
          SizedBox(
            height: 15,
          ),
        ],
      ),
      //Positioned(child: AdWidget(ad: _bannerAd),bottom: 0,),   ],
      // ),
    );
  }
}
