import 'package:cresas/game/GameScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

late String previousBackgroundImage;
late String previousZ1Image;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  final List<String> texts = [
    'In the celestial realm of Mount Olympus, Zeus, the mighty god of thunder and ruler of the gods, found himself entangled in a web of conflicts with his fellow Olympians. Discord and resentment simmered among the gods, leading to a cosmic rift that threatened to shatter the unity of their divine abode.',
    'Frustrated with the constant bickering and power struggles, Zeus sought a solution to bring harmony back to Olympus. In a moment of divine inspiration, he devised a radical plan – to descend to the mortal realm and experience life as a human. By doing so, Zeus believed he could gain a new perspective and mend the frayed relationships among the gods.',
    'With a thunderous flash, Zeus transformed into a mortal man, taking the name Cresus. Stripped of his godly powers, he found himself in the vibrant city of Athens, a place known for its wisdom, culture, and burgeoning power. As Cresus navigated the mortal world, he encountered both the marvels and hardships of human existence.',
    'Cresus, despite being a mere mortal, retained a trace of his divine wisdom and charisma. He quickly rose to prominence in Athens, earning the trust and admiration of its citizens. His leadership qualities and strategic mind set him apart, and he soon became a key figure in the political landscape of the city.',
    'As Cresus endeavored to unite Athens under his rule, he faced numerous challenges. The other gods, suspicious of his true identity, watched from Mount Olympus, their eyes narrowed with skepticism. Athena, the goddess of wisdom, was particularly wary, sensing a divine essence within the mortal Cresus.',
    'Cresus, undeterred by the divine scrutiny, worked tirelessly to improve the lives of Athenians. He fostered a golden age of prosperity, promoting arts, culture, and education. His leadership and benevolence won the hearts of the people, and soon Athens thrived under his guidance.',
    'However, not all gods were convinced of Cresus\'s intentions. Ares, the god of war, and Poseidon, the god of the sea, conspired against him, seeking to disrupt the peace in Athens. They stirred conflict among mortals, hoping to create chaos that would reflect poorly on Cresus.',
    'Undaunted, Cresus faced the challenges head-on. Through diplomacy and strategic prowess, he quelled the tensions, proving that the mortal realm could indeed find order and peace without divine intervention. As Athens flourished under Cresus\'s rule, even the skeptical gods on Mount Olympus began to recognize the wisdom behind his actions.',
    'In a moment of revelation, Zeus revealed his true identity to the other gods, showcasing the positive changes that had occurred in Athens under his mortal guise. The Olympians, humbled by the transformation and success of Cresus, set aside their differences and reconciled.',
    'He decided to take a revenge and get all surroundings.',
  ];

  final List<String> backgroundImages = [
    'images/onb/1.png',
    'images/onb/2.png',
    'images/onb/3.png',
    'images/onb/4.png',
  ];

  final List<String> z1Images = [
    'images/onb/z1.png',
    'images/onb/z2.png',
  ];

  final List<int> changeBackgroundIndices = [2, 4, 6];
  final List<int> changeZ1Indices = [3];

  @override
  void initState() {
    super.initState();
    previousBackgroundImage = backgroundImages[0];
    previousZ1Image = z1Images[0];
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

  void updateScreen() async {
    if (currentIndex == texts.length - 1) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardingComplete', true);
      bool ax = prefs.getBool('onboardingComplete') ?? false;
      if (ax) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainGameScreen()),
        );
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainGameScreen()),
      );
    }
    setState(() {
      currentIndex = (currentIndex + 1) % texts.length;
    });
    return;
  }

  String getBackgroundImage() {
    if (currentIndex == 2 || currentIndex == 3) return backgroundImages[1];
    if (currentIndex == 4 || currentIndex == 5) return backgroundImages[2];
    if (currentIndex == 6 || currentIndex >= 7) return backgroundImages[3];
    return backgroundImages[0];
  }

  String getZ1Image() {
    return currentIndex >= 3 ? z1Images[1] : z1Images[0];
  }

  @override
  Widget build(BuildContext context) {
    String currentBackgroundImage = getBackgroundImage();
    String currentZ1Image = getZ1Image();
    return Scaffold(
      body: GestureDetector(
        onTap: () => updateScreen(),
        child: Stack(
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 1000),
              firstChild: Image.asset(
                previousBackgroundImage,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              secondChild: Image.asset(
                currentBackgroundImage,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              crossFadeState: currentIndex > 0
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .7,
                child: Image.asset(
                  currentZ1Image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Image.asset(
                          'images/onb/history.png',
                          fit: BoxFit.contain,
                          height: 40,
                          width: 100,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            texts[currentIndex],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewM extends StatelessWidget {
  final String link;

  const ViewM({super.key, required this.link});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(link)),
      ),
    );
  }
}
