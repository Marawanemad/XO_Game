import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xogame/Cubit/States.dart';
import 'package:xogame/Cubit/cubit.dart';

import '../Components.dart';

// ignore: must_be_immutable
class MultyBoardScreen extends StatelessWidget {
  const MultyBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XOCubit, XoAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
            title: const Text(
              "Multy Player",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  XOCubit.get(context).result,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900),
                ),
                Container(
                  width: double.infinity,
                  height: 350,
                  color: Colors.white,
                  child: BoardGameCol(
                      cubit: XOCubit.get(context), isSingle: false),
                ),
                const SizedBox(height: 50),
                repeatButton(cubit: XOCubit.get(context)),
              ],
            ),
          ),
        );
      },
    );
  }
}
