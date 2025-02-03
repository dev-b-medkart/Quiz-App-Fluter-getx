import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_app_getx/models/quiz_model.dart';

class PlayQuizController extends GetxController {
  var userAnswers = <int>[].obs;
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
  }

  createQuiz(Quiz? quiz) {
    userAnswers.value = List.filled((quiz?.questions ?? []).length, -1);
  }

  void selectAnswer(int questionIndex, int option) {
    userAnswers[questionIndex] = option;
    // update();
  }
}
