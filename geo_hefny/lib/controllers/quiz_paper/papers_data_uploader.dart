import 'dart:convert';
import 'package:get/get.dart';
import '../../utils/logger.dart';
import '../../firebase/myPathes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../firebase/loading_status.dart';
import '../../models/quiz_paper_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String folderName = '/assets/DB/papers';

class PapersDataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  uploadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fi = FirebaseFirestore.instance;

    try {
      //read asset folder
      final manifestContent = await DefaultAssetBundle.of(Get.context!)
          .loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final papersInAsset = manifestMap.keys
          .where((path) =>
              path.startsWith('assets/DB/papers/') && path.contains('.json'))
          .toList();

      final List<QuizPaperModel> quizPapers = [];

      for (var paper in papersInAsset) {
        String stringPaperContent = await rootBundle.loadString(paper);
        quizPapers.add(QuizPaperModel.fromString(stringPaperContent));
      }

      var batch = fi.batch();

      for (var paper in quizPapers) {
        batch.set(
          quizePaperFR.doc(paper.id),
          {
            "title": paper.title,
            "image_url": paper.imageUrl,
            "Description": paper.description,
            "questions_count":
                paper.questions == null ? 0 : paper.questions!.length
          },
        );

        for (var questions in paper.questions!) {
          final questionPath =
              questionsFR(paperId: paper.id, questionsId: questions.id);

          batch.set(questionPath, {
            "question": questions.question,
            "correct_answer": questions.correctAnswer,
            "questionImage": questions.questionImage,
          });

          for (var answer in questions.answers) {
            batch.set(questionPath.collection('answers').doc(answer.identifier),
                {"identifier": answer.identifier, "answer": answer.answer});
          }
        }
      }
      await batch.commit();
      loadingStatus.value = LoadingStatus.completed;
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }
}
