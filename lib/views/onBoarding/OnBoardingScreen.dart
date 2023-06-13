import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/data/services/noteController.dart';
import 'package:note_taker/res/spacing/horizontal_spacing.dart';
import 'package:note_taker/res/spacing/vertical_spacing.dart';
import 'package:note_taker/views/Login/Login.dart';
import 'package:note_taker/views/SignUP/SignUP.dart';
import 'package:note_taker/widget/Mytext.dart';
import 'package:note_taker/widget/backgroundImage.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final NoteController noteController = Get.put(NoteController());

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const BackgroundImage(imageUrl: 'asset/images/img_1.png'),
              AppVerticalSpacing.verticalSpacingXL,

              loading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                  //Color(0xff5771F9),
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  noteController.signInWithGoogle(context);
                  setState(() {
                    loading = false;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey[700],
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Continue With Google",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "lato",
                      ),
                    ),
                    //
                    const SizedBox(
                      width: 10.0,
                    ),
                    //
                    Image.asset(
                      'asset/images/google.png',
                      height: 36.0,
                    ),
                  ],
                ),
              ),
              AppVerticalSpacing.verticalSpacingE,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){Get.to(const SignUP());},
                    child: MyText(
                      title: 'Sign Up',
                    ),
                  ),
                  AppHorizontalSpacing.horizontalSpacingXS,
                  ElevatedButton(
                    onPressed: (){
                      Get.to(const Login());
                    },
                    child: MyText(
                      title: 'Login',
                      align: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}