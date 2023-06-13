
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_taker/res/responsiveness.dart';
import 'package:note_taker/res/spacing/vertical_spacing.dart';
import 'package:note_taker/views/onBoarding/OnBoardingScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    timer();
  }

  Future<void> timer() async {
    Timer.periodic(const Duration(milliseconds: 5000), (timer) {
      setState(() {
        _progressValue = _progressValue + 0.1;
        if (_progressValue >= 1) {
          _progressValue = 1;
          timer.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  const OnBoardingScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        resizeToAvoidBottomInset: true,
        body:Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/images/icon.png",
                      ),
                    ),
                  ),
                ),
              ),
              //
              const Text(
                "Create and Manage your Notes",
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "lato",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                        value: _progressValue,
                      ),
                    ),
                  ),
                  Text(
                    " ${(_progressValue * 100).round()}%",
                    style: const TextStyle(fontSize: 12,color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}