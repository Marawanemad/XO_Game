import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xogame/Cubit/States.dart';
import 'package:xogame/Cubit/cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XOCubit, XoAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = XOCubit.get(context);
        int length = cubit.history.length;
        print(cubit.history.toString());
        return Container(
            color: Colors.white,
            child: cubit.history.isNotEmpty
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        // to make slide to show delete button or any button i want to make it
                        Slidable(
                          endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              extentRatio: 0.3,
                              children: [
                                SlidableAction(
                                  spacing: 3,
                                  onPressed: (context) {
                                    cubit.DeleteData(
                                        id: cubit.history[index]['id']);
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Text(cubit.history[index]['name']),
                              )),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      " Win   = ${cubit.history[index]['win']}",
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Draw = ${cubit.history[index]['draw']}",
                                      style:
                                          const TextStyle(color: Colors.amber),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Lose = ${cubit.history[index]['lose']}",
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.grey),
                    itemCount: length)
                : const Center(child: Text("No History Yet")));
      },
    );
  }
}
