import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final pageViewController =
      PageController(viewportFraction: 0.6, initialPage: 100);
  Color backgroundColor = Colors.pink;
  Color backgroundBefore = Colors.pink;
  int currentIndex = 0;
  double size = 0;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    controller.addListener(() {});
  }

  double rotateContainer(index) {
    if (index == currentIndex) {
      return 1;
    } else {
      return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBefore,
      body: Stack(
        alignment: Alignment.center,
        children: [
          OverflowBox(
            maxWidth: MediaQuery.of(context).size.height * 1.5,
            maxHeight: MediaQuery.of(context).size.height * 1.5,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: controller,
                curve: Curves.fastOutSlowIn,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                ),
                width: MediaQuery.of(context).size.height * 1.5,
                height: MediaQuery.of(context).size.height * 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: pageViewController,
              onPageChanged: (value) {
                setState(() {
                  isChanged = !isChanged;
                  currentIndex = value;
                  backgroundColor = backgroundColor == Colors.pink
                      ? Colors.amber
                      : Colors.pink;
                });
                controller.forward().then((value) {
                  controller.reset();
                  setState(() {
                    backgroundBefore = backgroundColor;
                  });
                });
              },
              itemBuilder: (context, index) {
                final currentAngle = rotateContainer(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: AnimatedRotation(
                      curve: Curves.fastEaseInToSlowEaseOut,
                      turns: currentAngle,
                      duration: const Duration(seconds: 1),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Image.asset('assets/maroon-5-v-songbook.jpg'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
