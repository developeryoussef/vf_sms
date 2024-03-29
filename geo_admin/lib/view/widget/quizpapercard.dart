import 'package:easy_separator/easy_separator.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import '../../main.dart';
import 'iconwithtext.dart';
import '../../controller/quizpagecontroller.dart';
import '../../model/quizpapermodel.dart';

class QuizPaperCard extends GetView<QuizPaperController> {
  const QuizPaperCard({Key? key, required this.model}) : super(key: key);

  final QuizPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ColoredBox(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: Image.asset('assets/Picture1.png'),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: TextStyle(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 15);
                            },
                            children: [
                              IconWithText(
                                  icon: Icon(Icons.help_outline_sharp,
                                      color: Colors.blue[700]),
                                  text: Text(
                                    '${model.questionsCount} quizes',
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                    ),
                                  )),
                              IconWithText(
                                  icon: const Icon(Icons.timer,
                                      color: Colors.blueGrey),
                                  text: Text(
                                    model.timeInMinits(),
                                    style: TextStyle(color: Colors.blueGrey),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Get.find<NotificationService>().showQuizCompletedNotification(id: 1, title: 'Sampole', body: 'Sample', imageUrl: model.imageUrl, payload: json.encode(model.toJson())  );
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        child: const Icon(
                          Icons.leaderboard,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: mainColor),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
