import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xogame/Cubit/States.dart';
import 'package:xogame/Cubit/cubit.dart';

class MainScreens extends StatelessWidget {
  const MainScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XOCubit, XoAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = XOCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: cubit.screens[cubit.currintIndex],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            // to make BottomNavigatorBar Circular
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                  currentIndex: cubit.currintIndex,
                  elevation: 0,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color.fromARGB(235, 112, 109, 109),
                  backgroundColor: const Color.fromARGB(255, 70, 163, 249),
                  onTap: (int index) {
                    cubit.changeCurrintIndex(index);
                  },
                  items: cubit.bottomNavList),
            ),
          ),
        );
      },
    );
  }
}
