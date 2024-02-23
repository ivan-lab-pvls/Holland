import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GameScreen.dart';

class FindPairsGame extends StatefulWidget {
  final String nameCountry;

  const FindPairsGame({super.key, required this.nameCountry});
  @override
  _FindPairsGameState createState() => _FindPairsGameState();
}

class _FindPairsGameState extends State<FindPairsGame> {
  late List<String> gridItems;
  List<String> matchedItems = [];
  String? selectedItem;
  late int selectedIndex;
  int? tappedIndex;
  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void saveCountryAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> countries = prefs.getStringList('countries') ?? [];
    countries.add(widget.nameCountry);
    await prefs.setStringList('countries', countries);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainGameScreen()));
  }

  void initializeGame() {
    List<String> images = [
      'images/game/x1.png',
      'images/game/x2.png',
      'images/game/x3.png',
      'images/game/x4.png',
      'images/game/x5.png',
      'images/game/x6.png',
      'images/game/x7.png',
      'images/game/x8.png',
    ];

    gridItems = List.from(images)..addAll(images);
    gridItems.shuffle(Random.secure());
  }

  BoxDecoration getDecoration(int index) {
    if (tappedIndex == index) {
      return BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent, // Цвет контура
          width: 10, // Толщина контура
        ),
        borderRadius: BorderRadius.circular(10), // Радиус скругления углов
      );
    } else {
      return BoxDecoration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/game/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio:
                      MediaQuery.of(context).size.aspectRatio * 1.4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  String item = gridItems[index];
                  bool isVisible = !matchedItems.contains(item);

                  return Visibility(
                    visible: isVisible,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedItem == null) {
                            selectedItem = item;
                            selectedIndex = index;
                          } else {
                            if (selectedItem == item &&
                                selectedIndex != index) {
                              matchedItems.add(item);
                              if (matchedItems.length == gridItems.length / 2) {
                                saveCountryAndNavigate();
                              }
                            }
                            selectedItem = null;
                          }
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: getDecoration(index),
                        child: Image.asset(
                          item,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
