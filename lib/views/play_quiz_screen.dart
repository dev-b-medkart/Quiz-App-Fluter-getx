import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_getx/controllers/home_page_controller.dart';
import 'package:quiz_app_getx/controllers/play_quiz_controller.dart';
import 'package:quiz_app_getx/views/quiz_result_screen.dart';

import '../models/quiz_model.dart';

class PlayQuizPage extends StatefulWidget {
  // final Quiz quiz;

  const PlayQuizPage({super.key});

  @override
  State<PlayQuizPage> createState() => _PlayQuizPageState();
}

class _PlayQuizPageState extends State<PlayQuizPage> {
  @override
  void initState() {
    super.initState(); // Call parent initState()
    final homeController = Get.find<HomeController>();
  }


  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final playQuizController = Get.put(PlayQuizController());
    playQuizController.createQuiz(homeController.quiz);
    final quizList = (homeController.quiz?.questions ?? []);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz:  ${homeController.quiz?.title}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: PageView.builder(
        controller: playQuizController.pageController,
        scrollDirection: Axis.vertical,
        itemCount: quizList.length,
        onPageChanged: (value) {
          playQuizController.currentPage.value = value;
        },
        itemBuilder: (context, index) {
          return Obx(() {
            return QuestionCard(
                questionIndex: index,
                question: quizList[index].text,
                options: quizList[index].options,
                onAnswer: playQuizController.selectAnswer,
                selectedOption: playQuizController.userAnswers[index]);
          });
        },
      ),
      floatingActionButton: Obx(
        () {
          // print("playQuizController.currentPage.value ${playQuizController.currentPage.value}");
          // print("quizList.length ${quizList.length- 1}");
          if (playQuizController.currentPage.value == quizList.length - 1) {
            return FloatingActionButton.extended(
              onPressed: () {
                if (homeController.quiz != null) {
                  Get.offAll(QuizResult(
                      quiz: homeController.quiz!,
                      userAnswers: playQuizController.userAnswers));
                }
              },
              label: Text('Submit Quiz',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              icon: Icon(Icons.check),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final int questionIndex;
  final String question;
  final List<String> options;
  final void Function(int questionIndex, int option) onAnswer;
  final int selectedOption;
  const QuestionCard(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.options,
      required this.onAnswer,
      required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<PlayQuizController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Question ${questionIndex + 1}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            question,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
          ),
        ),
        Column(
          children: options.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: OutlinedButton(
                onPressed: () {
                  onAnswer(questionIndex, entry.key);
                  print('option $selectedOption');
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: selectedOption == entry.key
                      ? Colors.blue
                      : Colors.red[400], // ✅ Background color
                  foregroundColor: Colors.white, // ✅ Text color
                  side: BorderSide(
                      color: Colors.black, width: 1), // ✅ Border color
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 24), // ✅ Padding
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10)), // ✅ Rounded corners
                ),
                child: Text(entry.value),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:quiz_app_getx/views/quiz_result_screen.dart';
//
// import '../models/quiz_model.dart';
//
// class PlayQuizPage extends StatefulWidget {
//   final Quiz quiz;
//   const PlayQuizPage({super.key, required this.quiz});
//
//   @override
//   State<PlayQuizPage> createState() => _PlayQuizPageState();
// }
//
// PageController _pageController = PageController();
//
// class _PlayQuizPageState extends State<PlayQuizPage> {
//   late List<int> userAnswers; // Declare without initializing
//
//   @override
//   void initState() {
//     super.initState(); // Call parent initState()
//     userAnswers = List.filled(widget.quiz.questions.length,
//         -1); // ✅ Correct: Assign value to instance variable
//   }
//
//   void onAnswer(int questionIndex, int option) {
//     setState(() {
//       userAnswers[questionIndex] = option;
//     });
//   }
//
//   ValueNotifier<int> currentPage = ValueNotifier(0);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Quiz:  ${widget.quiz.title}',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.green[300],
//       ),
//       body: PageView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: widget.quiz.questions.length,
//         onPageChanged: (value) {
//           currentPage.value = value;
//         },
//         itemBuilder: (context, index) {
//           return QuestionCard(
//               questionIndex: index,
//               question: widget.quiz.questions[index].text,
//               options: widget.quiz.questions[index].options,
//               onAnswer: onAnswer,
//               selectedOption: userAnswers[index]);
//         },
//       ),
//       floatingActionButton: ValueListenableBuilder(
//         valueListenable: currentPage,
//         builder: (context, value, child) {
//           // print('value $value');
//           // print('value ${widget.quiz.questions.length - 1}');
//           if (value == widget.quiz.questions.length - 1) {
//             return FloatingActionButton.extended(
//               onPressed: () {
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                         builder: (context) => QuizResult(
//                             quiz: widget.quiz, userAnswers: userAnswers)),
//                     (route) => false);
//               },
//               label: Text('Submit Quiz',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//               icon: Icon(Icons.check),
//             );
//           } else {
//             return SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }
//
// class QuestionCard extends StatelessWidget {
//   final int questionIndex;
//   final String question;
//   final List<String> options;
//   final void Function(int questionIndex, int option) onAnswer;
//   final int selectedOption;
//   const QuestionCard(
//       {super.key,
//       required this.questionIndex,
//       required this.question,
//       required this.options,
//       required this.onAnswer,
//       required this.selectedOption});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'Question ${questionIndex + 1}',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             question,
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
//           ),
//         ),
//         Column(
//           children: options.asMap().entries.map((entry) {
//             return Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: OutlinedButton(
//                 onPressed: () {
//                   onAnswer(questionIndex, entry.key);
//                   print('option $selectedOption');
//                 },
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: selectedOption == entry.key
//                       ? Colors.blue
//                       : Colors.red[400], // ✅ Background color
//                   foregroundColor: Colors.white, // ✅ Text color
//                   side: BorderSide(
//                       color: Colors.black, width: 1), // ✅ Border color
//                   padding: EdgeInsets.symmetric(
//                       vertical: 12, horizontal: 24), // ✅ Padding
//                   shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(10)), // ✅ Rounded corners
//                 ),
//                 child: Text(entry.value),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
