import 'package:cresas/onBoarding/OnBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'openGame.dart';

class MainGameScreen extends StatefulWidget {
  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

Future<List<String>> getSavedCountries() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('countries') ?? [];
}

String getImagePath(String country, List<String> savedCountries) {
  String basePath = 'images/game/';
  return savedCountries.contains(country)
      ? '${basePath}orange/'
      : '${basePath}green/';
}

class _MainGameScreenState extends State<MainGameScreen> {
  bool isSettings = false;
  bool isInfo = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/game/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<String>>(
                future: getSavedCountries(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData) {
                    return Center(child: Text('Error loading countries'));
                  }

                  List<String> savedCountries = snapshot.data!;

                  return Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * .2,
                        child: buildCountryItem(
                          context,
                          'IOANNIA',
                          savedCountries,
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height * .34,
                          left: MediaQuery.of(context).size.width * .16,
                          child: buildCountryItem(
                              context, 'PETRAS', savedCountries)),
                      Positioned(
                          top: MediaQuery.of(context).size.height * .013,
                          left: MediaQuery.of(context).size.width * .045,
                          child: buildCountryItem(
                              context, 'THESSALONIKI', savedCountries)),
                      Positioned(
                          bottom: MediaQuery.of(context).size.height * .11,
                          left: MediaQuery.of(context).size.width * .28,
                          child: buildCountryItem(
                              context, 'KOZANI', savedCountries)),
                      Positioned(
                          bottom: MediaQuery.of(context).size.height * .55,
                          left: MediaQuery.of(context).size.width * .15,
                          child: buildCountryItem(
                              context, 'LARISSA', savedCountries)),
                      Positioned(
                          bottom: MediaQuery.of(context).size.height * .49,
                          left: MediaQuery.of(context).size.width * .3,
                          child: buildCountryItem(
                              context, 'KOMOTINI', savedCountries)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * .1),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .65,
                            width: MediaQuery.of(context).size.width * .4,
                            child: Image.asset(
                              'images/onb/z2.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isSettings = true;
                                    isInfo = false;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child:
                                      Image.asset('images/game/settings.png'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isInfo = true;
                                    isSettings = false;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset('images/game/info.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isSettings == true)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .6,
                            width: MediaQuery.of(context).size.width * .4,
                            child: Stack(
                              children: [
                                Image.asset('images/game/settingsX.png'),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSettings = false;
                                          isInfo = false;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                            'images/game/cancel.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ViewM(
                                                              link:
                                                                  'https://docs.google.com/document/d/104da3N6VAo0slqF9gguGnk9mWe6oZsKqR3TBi3j9wFs/edit?usp=sharing')));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 100,
                                              child: Image.asset(
                                                  'images/game/priv.png'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ViewM(
                                                              link:
                                                                  'https://docs.google.com/document/d/1oPSYTCvM-kxXCVLz_asAfQg2yv1RpM1dEgvUT2vYBtc/edit?usp=sharing')));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 100,
                                              child: Image.asset(
                                                  'images/game/terms.png'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (isInfo == true)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .6,
                            width: MediaQuery.of(context).size.width * .4,
                            child: Stack(
                              children: [
                                Image.asset('images/game/infoX.png'),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSettings = false;
                                          isInfo = false;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                            'images/game/cancel.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OnBoardingScreen()),
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 100,
                                            child: Image.asset(
                                                'images/game/history.png'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget buildCountryItem(
    BuildContext context, String countryName, List<String> savedCountries) {
  return InkWell(
    onTap: () {
      if (savedCountries.contains(countryName)) {
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FindPairsGame(nameCountry: countryName)),
        );
      }
    },
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          getImagePath(countryName, savedCountries) + '1.png',
          height: MediaQuery.of(context).size.height * .6,
        ),
        Text(
          countryName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
}
