import 'package:get/get.dart';

import '../models/quiz_model.dart';
import '../services/hive_service.dart';
import '../views/create_quiz_screen.dart';

class HomeController extends GetxController {
  var quizzes = <Quiz>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HiveService.init();
    loadQuizzes();
  }

  void loadQuizzes() {
    quizzes.value = HiveService.getQuizzes();
  }

  void deleteQuiz(String quizTitle) {
    HiveService.deleteQuiz(quizTitle);
    loadQuizzes();
  }

  Future<void> addQuiz() async {
    Quiz? newQuiz = await Get.to(() => CreateQuizPage());
    if (newQuiz != null) {
      await HiveService.addQuiz(newQuiz);
      loadQuizzes();
    }
  }
  Quiz? quiz;

  void playQuiz(Quiz quiz1) {
    quiz=quiz1;
    // Get.to(() => PlayQuizPage(quiz: quiz));
  }
}
