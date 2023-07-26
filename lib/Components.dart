import 'package:flutter/material.dart';

Widget ChooseGameShape(
    {required String image,
    required String typeName,
    required imageColor,
    required pageName,
    required context,
    required cubit}) {
  return InkWell(
    onTap: () {
      cubit.playerName != ''
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageName))
          : showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  "Alert Message",
                ),
                content: SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        const Divider(
                          color: Colors.black,
                        ),
                        const SizedBox(height: 25),
                        const Text('Player Name must not be Empty'),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => const Color.fromRGBO(
                                        197, 197, 197, 0.525))),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              "Close",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            );
      cubit.repeatGame();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 115,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: imageColor,
          ),
          child: Image(
            image: AssetImage(image),
          ),
        ),
        Container(
          height: 40,
          width: 130,
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.horizontal(
                end: Radius.circular(50), start: Radius.circular(5)),
            color: const Color.fromARGB(255, 71, 34, 174),
          ),
          child: Center(
            child: Text(
              typeName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}

Widget ScoreBoardCounter({required String word, required int score}) {
  return Container(
    width: 80,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(163, 162, 162, 162),
      ),
      gradient: const LinearGradient(
        begin: AlignmentDirectional.topEnd,
        end: AlignmentDirectional.bottomEnd,
        colors: [
          Color.fromARGB(163, 162, 162, 162),
          Color.fromARGB(0, 247, 243, 243),
        ],
      ),
      color: const Color.fromARGB(255, 247, 243, 243),
    ),
    child: Column(
      children: [
        Text(
          score.toString(),
          style: const TextStyle(
              fontSize: 30, color: Color.fromARGB(255, 70, 163, 249)),
        ),
        Container(
          height: 2,
          color: const Color.fromARGB(163, 162, 162, 162),
        ),
        Text(
          word,
          style: const TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 252, 177, 80)),
        ),
      ],
    ),
  );
}

Widget BoardGameCol({required cubit, bool isSingle = true}) {
  return SizedBox(
    width: double.infinity,
    height: 350,
    child: GridView.count(
      // to Stop scrolling
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      crossAxisCount: 3,
      children: List.generate(
        9,
        (index) => InkWell(
          onTap: () {
            cubit.gameOver ||
                    cubit.PlayerO.contains(index) ||
                    cubit.PlayerX.contains(index)
                ? null
                : {
                    cubit.ChangeOnPressed(index),
                    if (isSingle == true && cubit.turn < 9) cubit.autoPlay()
                  };
          },
          child: Container(
            width: 100,
            height: 100,
            color: const Color.fromRGBO(197, 197, 197, 0.525),
            child: cubit.PlayerX.contains(index)
                ? const Image(
                    image: AssetImage("assets/images/X_image.png"),
                    color: Colors.red,
                  )
                : cubit.PlayerO.contains(index)
                    ? const Image(
                        image: AssetImage("assets/images/O_image.png"),
                        color: Colors.blue,
                      )
                    : null,
          ),
        ),
      ),
    ),
  );
}

Widget repeatButton({required cubit}) {
  return ElevatedButton.icon(
      onPressed: () {
        cubit.repeatGame();
      },
      icon: const Icon(Icons.replay),
      label: const Text("Repeat the game"));
}
