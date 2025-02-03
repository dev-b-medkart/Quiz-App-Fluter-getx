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
  var userAnswers = <int>[];
  int score=0;

  void submitQuiz(List<int>userAnswers){
    this.userAnswers=userAnswers;
    for (int i = 0; i < (quiz?.questions ??[]).length; i++) {
      if (userAnswers[i] == quiz?.questions[i].correctOptionIndex) {
        score++;
      }
    }
  }

  void resetScore(){
    score=0;
  }


  void playQuiz(Quiz quiz) {
    // quiz=quiz1;
    this.quiz=quiz;
  }
}
