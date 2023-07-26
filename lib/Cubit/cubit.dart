import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:xogame/Cubit/States.dart';
import 'package:xogame/LayOuts/HistoryScreen.dart';
import 'package:xogame/LayOuts/HomeScreen.dart';
import 'package:xogame/LayOuts/ScoreBoardScreen.dart';

class XOCubit extends Cubit<XoAppStates> {
  XOCubit() : super(IntialAppState());
  static XOCubit get(context) => BlocProvider.of(context);

  int currintIndex = 0;
  List<BottomNavigationBarItem> bottomNavList = [
    const BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_filled)),
    const BottomNavigationBarItem(label: "Score", icon: Icon(Icons.gamepad)),
    const BottomNavigationBarItem(
        label: "History", icon: Icon(Icons.list_alt_rounded)),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const ScoreBoard(),
    const HistoryScreen(),
  ];
  void changeCurrintIndex(int index) {
    currintIndex = index;
    emit(ChangeBottomNAVState());
  }

  String result = '';
  int turn = 0;
  bool gameOver = false;
  List<int> PlayerX = [];
  List<int> PlayerO = [];
  String activePlayer = 'x';

  void ChangeOnPressed(int index) {
    turn++;
    activePlayer == 'x' ? PlayerX.add(index) : PlayerO.add(index);
    activePlayer == 'x' ? activePlayer = 'o' : activePlayer = 'x';
    String winner = checkWinner();
    if (winner != '') {
      gameOver = true;
      winner == 'X' ? win++ : lose++;

// to check if name in dataBase update row value if not add row for it
      history.any((element) => element['name'] == playerName)
          ? UpdateData()
          : insertToDataBase();
      emit(ChangeOnPressedState());

      result = '$winner is the winner';
    } else if (!gameOver && turn == 9) {
      draw++;

// to check if name in dataBase update row value if not add row for it
      history.any((element) => element['name'] == playerName)
          ? UpdateData()
          : insertToDataBase();
      result = 'it\'s Draw';
      emit(ChangeOnPressedState());
    }
    emit(ChangeOnPressedState());
  }

  void repeatGame() {
    PlayerX = [];
    PlayerO = [];
    activePlayer = 'x';
    result = '';
    turn = 0;
    gameOver = false;
    emit(RepeatGamePressedState());
  }

  void autoPlay() {
    int index = 0;
    List<int> emptyCell = [];
    for (int i = 0; i < 9; i++) {
      if (!(PlayerX.contains(i) || PlayerO.contains(i))) {
        emptyCell.add(i);
      }
    }
    // start Attack conditions
    if (WinnerCondition(PlayerO, 0, 1) && emptyCell.contains(2)) {
      index = 2;
    } else if (WinnerCondition(PlayerO, 0, 2) && emptyCell.contains(1)) {
      index = 1;
    } else if (WinnerCondition(PlayerO, 1, 2) && emptyCell.contains(0)) {
      index = 0;
    } else if (WinnerCondition(PlayerO, 3, 4) && emptyCell.contains(5)) {
      index = 5;
    } else if (WinnerCondition(PlayerO, 3, 5) && emptyCell.contains(4)) {
      index = 4;
    } else if (WinnerCondition(PlayerO, 4, 5) && emptyCell.contains(3)) {
      index = 3;
    } else if (WinnerCondition(PlayerO, 6, 7) && emptyCell.contains(8)) {
      index = 8;
    } else if (WinnerCondition(PlayerO, 6, 8) && emptyCell.contains(7)) {
      index = 7;
    } else if (WinnerCondition(PlayerO, 7, 8) && emptyCell.contains(6)) {
      index = 6;
    } else if (WinnerCondition(PlayerO, 0, 3) && emptyCell.contains(6)) {
      index = 6;
    } else if (WinnerCondition(PlayerO, 0, 6) && emptyCell.contains(3)) {
      index = 3;
    } else if (WinnerCondition(PlayerO, 6, 3) && emptyCell.contains(0)) {
      index = 0;
    } else if (WinnerCondition(PlayerO, 1, 4) && emptyCell.contains(7)) {
      index = 7;
    } else if (WinnerCondition(PlayerO, 1, 7) && emptyCell.contains(4)) {
      index = 4;
    } else if (WinnerCondition(PlayerO, 4, 7) && emptyCell.contains(1)) {
      index = 1;
    } else if (WinnerCondition(PlayerO, 2, 5) && emptyCell.contains(8)) {
      index = 8;
    } else if (WinnerCondition(PlayerO, 2, 8) && emptyCell.contains(5)) {
      index = 5;
    } else if (WinnerCondition(PlayerO, 5, 8) && emptyCell.contains(2)) {
      index = 2;
    } else if (WinnerCondition(PlayerO, 0, 4) && emptyCell.contains(8)) {
      index = 8;
    } else if (WinnerCondition(PlayerO, 4, 8) && emptyCell.contains(0)) {
      index = 0;
    } else if (WinnerCondition(PlayerO, 0, 8) && emptyCell.contains(4)) {
      index = 4;
    } else if (WinnerCondition(PlayerO, 2, 4) && emptyCell.contains(6)) {
      index = 6;
    } else if (WinnerCondition(PlayerO, 4, 6) && emptyCell.contains(2)) {
      index = 2;
    } else if (WinnerCondition(PlayerO, 2, 6) && emptyCell.contains(4)) {
      index = 4;
      // Start defence Conditions
    } else if (WinnerCondition(PlayerX, 0, 1) && emptyCell.contains(2)) {
      index = 2;
    } else if (WinnerCondition(PlayerX, 0, 2) && emptyCell.contains(1)) {
      index = 1;
    } else if (WinnerCondition(PlayerX, 1, 2) && emptyCell.contains(0)) {
      index = 0;
    } else if (WinnerCondition(PlayerX, 3, 4) && emptyCell.contains(5)) {
      index = 5;
    } else if (WinnerCondition(PlayerX, 3, 5) && emptyCell.contains(4)) {
      index = 4;
    } else if (WinnerCondition(PlayerX, 4, 5) && emptyCell.contains(3)) {
      index = 3;
    } else if (WinnerCondition(PlayerX, 6, 7) && emptyCell.contains(8)) {
      index = 8;
    } else if (WinnerCondition(PlayerX, 6, 8) && emptyCell.contains(7)) {
      index = 7;
    } else if (WinnerCondition(PlayerX, 7, 8) && emptyCell.contains(6)) {
      index = 6;
    } else if (WinnerCondition(PlayerX, 0, 3) && emptyCell.contains(6)) {
      index = 6;
    } else if (WinnerCondition(PlayerX, 0, 6) && emptyCell.contains(3)) {
      index = 3;
    } else if (WinnerCondition(PlayerX, 6, 3) && emptyCell.contains(0)) {
      index = 0;
    } else if (WinnerCondition(PlayerX, 1, 4) && emptyCell.contains(7)) {
      index = 7;
    } else if (WinnerCondition(PlayerX, 1, 7) && emptyCell.contains(4)) {
      index = 4;
    } else if (WinnerCondition(PlayerX, 4, 7) && emptyCell.contains(1)) {
      index = 1;
    } else if (WinnerCondition(PlayerX, 2, 5) && emptyCell.contains(8)) {
      index = 8;
    } else if (WinnerCondition(PlayerX, 2, 8) && emptyCell.contains(5)) {
      index = 5;
    } else if (WinnerCondition(PlayerX, 5, 8) && emptyCell.contains(2)) {
      index = 2;
    } else if (WinnerCondition(PlayerX, 0, 4) && emptyCell.contains(8)) {
      index = 8;
    } else if (WinnerCondition(PlayerX, 4, 8) && emptyCell.contains(0)) {
      index = 0;
    } else if (WinnerCondition(PlayerX, 0, 8) && emptyCell.contains(4)) {
      index = 4;
    } else if (WinnerCondition(PlayerX, 2, 4) && emptyCell.contains(6)) {
      index = 6;
    } else if (WinnerCondition(PlayerX, 4, 6) && emptyCell.contains(2)) {
      index = 2;
    } else if (WinnerCondition(PlayerX, 2, 6) && emptyCell.contains(4)) {
      index = 4;
    } else {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCell.length);
      index = emptyCell[randomIndex];
    }
    if (checkWinner() == '')
      // to make delay in autoPlay not playing with user
      Timer(const Duration(milliseconds: 250), () {
        ChangeOnPressed(index);
      });
    emit(ChangeOnPressedState());
  }

  WinnerCondition(List list, int x, int y, [int? z]) {
    return z == null
        ? list.contains(x) && list.contains(y)
        : list.contains(x) && list.contains(y) && list.contains(z);
  }

  String checkWinner() {
    String winner = '';
    if (WinnerCondition(PlayerX, 0, 1, 2) ||
        WinnerCondition(PlayerX, 3, 4, 5) ||
        WinnerCondition(PlayerX, 6, 7, 8) ||
        WinnerCondition(PlayerX, 0, 3, 6) ||
        WinnerCondition(PlayerX, 1, 4, 7) ||
        WinnerCondition(PlayerX, 2, 5, 8) ||
        WinnerCondition(PlayerX, 0, 4, 8) ||
        WinnerCondition(PlayerX, 2, 4, 6)) {
      winner = "X";
    } else if (WinnerCondition(PlayerO, 0, 1, 2) ||
        WinnerCondition(PlayerO, 3, 4, 5) ||
        WinnerCondition(PlayerO, 6, 7, 8) ||
        WinnerCondition(PlayerO, 0, 3, 6) ||
        WinnerCondition(PlayerO, 1, 4, 7) ||
        WinnerCondition(PlayerO, 2, 5, 8) ||
        WinnerCondition(PlayerO, 0, 4, 8) ||
        WinnerCondition(PlayerO, 2, 4, 6)) {
      winner = "O";
    } else {
      winner = '';
    }

    return winner;
  }

  Database? database;
  int win = 0;
  int lose = 0;
  int draw = 0;
  String playerName = '';

  void onCreateDataBase() {
    print("Data Base Created");
    // to declare database variable with path and version
    openDatabase(
      'XoGame.db', version: 1,
// to make creation
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE score(id INTEGER PRIMARY KEY ,name TEXT, win INTEGER ,lose INTEGER,draw INTEGER)');
        print("Table Created");
      },
      onOpen: (database) {
        print("Table Opened");

        getDataFromDataBase(database);
      },
    ).then((value) {
      database = value;
      emit(OnCreateDataBaseState());
    });
  }

  Future insertToDataBase() async {
    await database?.transaction((txn) async {
      win = 0;
      lose = 0;
      draw = 0;
      txn
          .rawInsert(
              'INSERT INTO score(name,win,lose,draw) VALUES("$playerName","$win","$lose","$draw")')
          .then((value) {
        print("Data insereted");

        getDataFromDataBase(database);
        emit(InsertDataBaseState());
      });
    });
  }

  List<Map> history = [];
  void getDataFromDataBase(database) {
    print("player name is ${playerName}");
    print(history.toString());
    history = [];
    database!.rawQuery("SELECT * FROM score").then((value) {
      value.forEach((element) {
        history.add(element);
      });
    });
    emit(GetDataBaseState());
  }

  void UpdateData() async {
    database!.rawUpdate(
        'UPDATE score SET win =? ,lose = ?, draw = ? WHERE name =? ',
        [win, lose, draw, playerName]).then((value) {
      print("Data Updated");
      getDataFromDataBase(database);
      emit(UpdateDataState());
    });
  }

  void DeleteData({required int id}) async {
    database!.rawDelete("DELETE FROM score  WHERE id = ?", [id]).then((value) {
      win = 0;
      lose = 0;
      draw = 0;
      print(value.toString());
      getDataFromDataBase(database);
      emit(DeleteDataState());
    });
  }
}
