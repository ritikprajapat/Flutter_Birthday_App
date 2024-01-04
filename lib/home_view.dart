import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:birthday_app/birthday.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  final ConfettiController controller;
  final Birthday birthday;
  const HomeView({
    Key? key,
    required this.controller,
    required this.birthday,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Lottie.network(
                            'https://lottie.host/99935392-f6c3-48e1-872b-973335abce63/C40UdRgVdQ.json',
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Hey, ${widget.birthday.name}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'HAPPY BIRTHDAY',
                              textStyle: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: widget.controller,
                  shouldLoop: true,
                  numberOfParticles: 10,
                  blastDirectionality: BlastDirectionality.explosive,
                  // emissionFrequency: 0.50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
