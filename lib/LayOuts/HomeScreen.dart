import 'package:flutter/material.dart';
import 'package:xogame/Cubit/States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xogame/Cubit/cubit.dart';
import 'package:xogame/LayOuts/SingleBoardScreen.dart';
import '../Components.dart';
import 'MultyBoardScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();

    return BlocConsumer<XOCubit, XoAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = XOCubit.get(context);
        nameController.text = cubit.playerName;
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Player Name',
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (value) {
                          cubit.playerName = nameController.text;
                          if (nameController.text != '') {
                            cubit.history.forEach((element) {
                              if (element['name'] == cubit.playerName) {
                                cubit.win = element['win'];
                                cubit.lose = element['lose'];
                                cubit.draw = element['draw'];
                              }
                            });
                            cubit.history.any((element) =>
                                    element['name'] == cubit.playerName)
                                ? cubit.UpdateData()
                                : cubit.insertToDataBase();
                            print("player name is ${cubit.playerName}");
                            print(cubit.history.any((element) =>
                                element['name'] == cubit.playerName));
                          }
                        },
                      ),
                    ]),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    children: [
                      Text(
                        "Choose Your Game",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ChooseGameShape(
                      image: 'assets/images/singlePlayerIcon.png',
                      typeName: 'SINGLE PLAYER',
                      imageColor: const Color.fromARGB(255, 252, 177, 80),
                      context: context,
                      pageName: const SingleBoardScreen(),
                      cubit: XOCubit.get(context)),
                  const SizedBox(height: 30),
                  ChooseGameShape(
                      image: 'assets/images/multyPlayersIcon.png',
                      typeName: 'TWO PLAYER',
                      context: context,
                      pageName: const MultyBoardScreen(),
                      imageColor: const Color.fromARGB(255, 70, 163, 249),
                      cubit: XOCubit.get(context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
