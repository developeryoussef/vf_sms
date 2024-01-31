// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/addquizcontroller.dart';
import '../../main.dart';
import '../../viewcontroller.dart';
import '../widget/custom_textfield.dart';

class QuizPage extends StatelessWidget {
  final String? path;
  final String? primary;
  const QuizPage({super.key, required this.primary, required this.path});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text(
                'Add ${path == 'quizpapers' ? 'Quiz' : 'Homework'} to $primary'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustonTextFormAuth(
                    hinttext: '${path == 'quizpapers' ? 'Quiz' : 'Homework'}',
                    labeltext: '${path == 'quizpapers' ? 'Quiz' : 'Homework'}',
                    iconData: Icons.format_list_numbered_rtl_outlined,
                    mycontroller: controller.quiznumber,
                    type: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2.5,
                    color: Colors.grey.shade300,
                  ),
                  QuizQuestions(
                    path: path,
                    primary: primary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuizQuestions extends StatelessWidget {
  final String? path;
  final String? primary;
  const QuizQuestions({
    required this.path,
    required this.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (controller) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Question ${controller.index.toString()}:',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: CustomQuizesTextField(
                    suffix: 'Question',
                    hinttext: 'The question',
                    mycontroller: controller.questionController,
                    type: TextInputType.multiline),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Options:',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                child: CustomQuizesTextField(
                    suffix: 'Question',
                    hinttext: 'Option 1',
                    mycontroller: controller.option1Controller,
                    type: TextInputType.name),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                child: CustomQuizesTextField(
                    suffix: 'Question',
                    hinttext: 'Option 2',
                    mycontroller: controller.option2Controller,
                    type: TextInputType.name),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                child: CustomQuizesTextField(
                    suffix: 'Question',
                    hinttext: 'Option 3',
                    mycontroller: controller.option3Controller,
                    type: TextInputType.name),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                child: CustomQuizesTextField(
                    suffix: 'Question',
                    hinttext: 'Option 4',
                    mycontroller: controller.option4Controller,
                    type: TextInputType.name),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: CustomQuizesTextField(
                    suffix: 'Question',
                    hinttext: 'Answer(A , B , C , D)',
                    mycontroller: controller.answerController,
                    type: TextInputType.text),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ListTile(
                  onTap: () async {
                    if (controller.option1Controller.text == null ||
                        controller.option1Controller.text == '') {
                      Get.snackbar('Quiz System', 'Please write Option 1');
                    } else if (controller.option2Controller.text == null ||
                        controller.option2Controller.text == '') {
                      Get.snackbar('Quiz System', 'Please write Option 2');
                    } else if (controller.quiznumber!.text == null ||
                        controller.questionController.text == '') {
                      Get.snackbar(
                          'Quiz System', 'Please write the quiz number');
                    } else if (controller.option3Controller.text == null ||
                        controller.option3Controller.text == '') {
                      Get.snackbar('Quiz System', 'Please write Option 3');
                    } else if (controller.option4Controller.text == null ||
                        controller.option4Controller.text == '') {
                      Get.snackbar('Quiz System', 'Please write Option 4');
                    } else if (controller.questionController.text == null ||
                        controller.questionController.text == '') {
                      Get.snackbar('Quiz System', 'Please write the question');
                    } else {
                      var laocalpath = FirebaseFirestore.instance
                          .collection(path!.toString());

                      await laocalpath
                          .doc(controller.quiznumber!.text.toString())
                          .set({
                        'Description': 'italian quizes',
                        'image_url': '',
                        'questions_count': controller.index,
                        'time_seconds': 900,
                        'title': '$primary',
                      });
                      await laocalpath
                          .doc(controller.quiznumber!.text.toString())
                          .collection('questions')
                          .doc(
                              '${controller.quiznumber!.text}${controller.index}')
                          .set({
                        'correct_answer': controller
                            .answerController.text.capitalize
                            .toString(),
                        'question':
                            controller.questionController.text.toString(),
                      });
                      await laocalpath
                          .doc(controller.quiznumber!.text.toString())
                          .collection('questions')
                          .doc(
                              '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                          .collection('answers')
                          .doc('A')
                          .set({
                        'answer': controller.option1Controller.text.capitalize,
                        'identifier': 'A',
                      });
                      await laocalpath
                          .doc(controller.quiznumber!.text.toString())
                          .collection('questions')
                          .doc(
                              '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                          .collection('answers')
                          .doc('B')
                          .set({
                        'answer': controller.option2Controller.text.capitalize,
                        'identifier': 'B',
                      });
                      await laocalpath
                          .doc(controller.quiznumber!.text.toString())
                          .collection('questions')
                          .doc(
                              '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                          .collection('answers')
                          .doc('C')
                          .set({
                        'answer': controller.option3Controller.text.capitalize,
                        'identifier': 'C',
                      });
                      await laocalpath
                          .doc(controller.quiznumber!.text.toString())
                          .collection('questions')
                          .doc(
                              '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                          .collection('answers')
                          .doc('D')
                          .set({
                        'answer': controller.option4Controller.text.capitalize,
                        'identifier': 'D',
                      });
                      controller.answerController.clear();
                      controller.option1Controller.clear();
                      controller.option2Controller.clear();
                      controller.option3Controller.clear();
                      controller.option4Controller.clear();
                      controller.questionController.clear();
                      controller.changeIndex();
                    }
                  },
                  title: Text(
                    'Create another question',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.add),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                child: Container(
                  child: Center(
                    child: Text(
                      'End quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  width: Get.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () async {
                  if (controller.option1Controller.text == null ||
                      controller.option1Controller.text == '') {
                    Get.snackbar('Quiz System', 'Please write Option 1');
                  } else if (controller.option2Controller.text == null ||
                      controller.option2Controller.text == '') {
                    Get.snackbar('Quiz System', 'Please write Option 2');
                  } else if (controller.quiznumber!.text == null ||
                      controller.questionController.text == '') {
                    Get.snackbar('Quiz System', 'Please write the quiz number');
                  } else if (controller.option3Controller.text == null ||
                      controller.option3Controller.text == '') {
                    Get.snackbar('Quiz System', 'Please write Option 3');
                  } else if (controller.option4Controller.text == null ||
                      controller.option4Controller.text == '') {
                    Get.snackbar('Quiz System', 'Please write Option 4');
                  } else if (controller.questionController.text == null ||
                      controller.questionController.text == '') {
                    Get.snackbar('Quiz System', 'Please write the question');
                  } else {
                    var laocalpath =
                        FirebaseFirestore.instance.collection(path!.toString());

                    await laocalpath
                        .doc(controller.quiznumber!.text.toString())
                        .set({
                      'Description': 'italian quizes',
                      'image_url': '',
                      'questions_count': controller.index,
                      'time_seconds': 900,
                      'title': '$primary',
                    });
                    await laocalpath
                        .doc(controller.quiznumber!.text.toString())
                        .collection('questions')
                        .doc(
                            '${controller.quiznumber!.text}${controller.index}')
                        .set({
                      'correct_answer': controller
                          .answerController.text.capitalize
                          .toString(),
                      'question': controller.questionController.text.toString(),
                    });
                    await laocalpath
                        .doc(controller.quiznumber!.text.toString())
                        .collection('questions')
                        .doc(
                            '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                        .collection('answers')
                        .doc('A')
                        .set({
                      'answer': controller.option1Controller.text.capitalize,
                      'identifier': 'A',
                    });
                    await laocalpath
                        .doc(controller.quiznumber!.text.toString())
                        .collection('questions')
                        .doc(
                            '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                        .collection('answers')
                        .doc('B')
                        .set({
                      'answer': controller.option2Controller.text.capitalize,
                      'identifier': 'B',
                    });
                    await laocalpath
                        .doc(controller.quiznumber!.text.toString())
                        .collection('questions')
                        .doc(
                            '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                        .collection('answers')
                        .doc('C')
                        .set({
                      'answer': controller.option3Controller.text.capitalize,
                      'identifier': 'C',
                    });
                    await laocalpath
                        .doc(controller.quiznumber!.text.toString())
                        .collection('questions')
                        .doc(
                            '${controller.quiznumber!.text.toString()}${controller.index.toString()}')
                        .collection('answers')
                        .doc('D')
                        .set({
                      'answer': controller.option4Controller.text.capitalize,
                      'identifier': 'D',
                    });
                    sharedPreferences!.setInt(
                        'initQuizIndex',
                        (int.parse(controller.quiznumber!.text.toString()) + 1)
                            .toInt());
                    Get.offAll(ViewController());
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
