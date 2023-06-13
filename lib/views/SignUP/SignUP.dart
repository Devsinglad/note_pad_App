import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/data/services/auth_services.dart';
import 'package:note_taker/data/services/noteController.dart';
import 'package:note_taker/res/spacing/vertical_spacing.dart';
import 'package:note_taker/res/textEditingControllers/textEditingControllers.dart';
import 'package:note_taker/views/Login/Login.dart';
import 'package:note_taker/widget/Mytext.dart';
import 'package:note_taker/widget/custom_textfield.dart';
class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool isLoading = false;
  @override
  void dispose() {
    final AuthenticationController authenticate =Get.put(AuthenticationController());
    authenticate.fullNameController.dispose();
    authenticate.confirmPasswordController.dispose();

    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticate =Get.put(AuthenticationController());
    final NoteController noteController = Get.put(NoteController());


    return Form(
      key: _formKey,
      child: Scaffold(
        body:  SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      title: 'Welcome',
                      fontSize: 36,
                      weight: FontWeight.w700,
                      //fonts: CustomTextStyle.header,
                    ),
                    AppVerticalSpacing.verticalSpacingXL,
                    CustomTextFormField(
                      obscureText: false,
                      readonly: false,
                      hintText: 'Enter full name ',
                      controller: authenticate.fullNameController,
                      validator: (str) => authenticate.validateName(
                          authenticate.fullNameController.text),
                    ),
                    AppVerticalSpacing.verticalSpacingE,
                    CustomTextFormField(
                      textInputType: TextInputType.number,
                      obscureText: false,
                      readonly: false,
                      hintText: 'Phone number',
                      controller: authenticate.phoneNumber,

                      validator: (str) =>
                          authenticate.validatePhoneNumber(
                            authenticate.phoneNumber.text.trim(),

                          ),
                    ),
                    AppVerticalSpacing.verticalSpacingE,
                    CustomTextFormField(
                      obscureText: false,
                      readonly: false,
                      hintText: 'Enter email address',
                      controller: authenticate.emailController,
                      validator: (str) => authenticate.validateEmail(
                        authenticate.emailController.text.trim(),
                      ),
                    ),
                    AppVerticalSpacing.verticalSpacingE,
                    CustomTextFormField(
                      obscureText: true,
                      readonly: false,
                      hintText: 'Enter password',
                      controller: authenticate.passwordController,
                      validator: (str) => authenticate.validatePassword(
                          authenticate.passwordController.text.trim()),
                    ),
                    AppVerticalSpacing.verticalSpacingE,
                    CustomTextFormField(
                      obscureText: true,
                      readonly: false,
                      hintText: 'Repeat password ',
                      textInputAction: TextInputAction.done,
                      controller: authenticate.confirmPasswordController,
                      validator: (str) =>
                          authenticate.validateConfirmPassword(
                              str,
                              authenticate.passwordController.text
                                  .trim()),
                    ),
                    AppVerticalSpacing.verticalSpacingXS,
                    ElevatedButton(
                      child: isLoading
                          ? const CircularProgressIndicator(
                        //color: Brand.white,
                        strokeWidth: 2,
                      )
                          : MyText(
                        title: 'Sign Up',
                        //fonts: CustomTextStyle.buttonTitle,
                      ),
                      onPressed: () async {
                        FocusScopeNode currentFocus =
                        FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                         await noteController.signUp(
                            authenticate.emailController.text,
                            authenticate.passwordController.text,
                           authenticate.phoneNumber.text,
                           authenticate.fullNameController.text,
                           context,
                          );
                          setState(() {
                            isLoading = false;
                          });
                        }

                        authenticate.fullNameController.clear();
                        authenticate.phoneNumber.clear();
                        authenticate.confirmPasswordController.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Login()));
                      },
                    ),
                    AppVerticalSpacing.verticalSpacingM,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(title: 'Already have an account? '),
                        MyText(
                            title: 'Sign In',
                            color: Colors.blue,
                            fontSize: 20,
                            weight: FontWeight.w500,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Login()));
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}