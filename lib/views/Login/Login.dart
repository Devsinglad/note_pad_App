import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/data/services/noteController.dart';
import 'package:note_taker/res/spacing/vertical_spacing.dart';
import 'package:note_taker/res/textEditingControllers/textEditingControllers.dart';
import 'package:note_taker/views/HomePage.dart';
import 'package:note_taker/views/SignUP/SignUP.dart';
import 'package:note_taker/widget/Mytext.dart';
import 'package:note_taker/widget/custom_textfield.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticate =Get.put(AuthenticationController());
    final NoteController noteController = Get.put(NoteController());

    return Form(
      key: _formKey,
      child:Scaffold(
        resizeToAvoidBottomInset: true,
        body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  title: 'Welcome Back!',
                  fontSize: 36,
                  weight: FontWeight.w600,
                ),
                AppVerticalSpacing.verticalSpacingXL,
                CustomTextFormField(
                  obscureText: false,
                  readonly: false,
                  hintText: 'Enter email address',
                  controller: authenticate.emailController,
                ),
                AppVerticalSpacing.verticalSpacingE,
                CustomTextFormField(
                  obscureText: false,
                  readonly: false,
                  hintText: 'Password',
                  controller: authenticate.passwordController,
                  textInputAction: TextInputAction.done,
                ),
                AppVerticalSpacing.verticalSpacingXS,
                MyText(title: 'Forgotten Password?'),
                AppVerticalSpacing.verticalSpacingD,
                ElevatedButton(
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                      : MyText(
                    title: 'Login In',
                  ),
                  onPressed: () async {
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                   await  noteController.signIn(
                      authenticate.emailController.text,
                      authenticate.passwordController.text,
                     context,
                   );
                    authenticate.emailController.clear();
                    authenticate.passwordController.clear();

                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                AppVerticalSpacing.verticalSpacingM,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(title: 'Don’t have an account? '),
                    MyText(
                        title: 'Sign up',
                        color: Colors.blue,
                        onTap: () {
                          Get.to(const SignUP());
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}