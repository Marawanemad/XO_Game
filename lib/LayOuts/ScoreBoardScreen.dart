import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xogame/Components.dart';
import 'package:xogame/Cubit/cubit.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Column(children: [
        const Text(
          "Your Score",
          style: TextStyle(fontSize: 30, color: Colors.green),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScoreBoardCounter(word: "Win", score: XOCubit.get(context).win),
            ScoreBoardCounter(word: "Draw", score: XOCubit.get(context).draw),
            ScoreBoardCounter(word: "Lose", score: XOCubit.get(context).lose),
          ],
        ),
        const SizedBox(height: 70),
        const Image(
          image: AssetImage("assets/images/ScoreBoardWinner.png"),
          fit: BoxFit.contain,
          width: 250,
          height: 250,
        )
      ]),
    );
  }
}
