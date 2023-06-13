import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_taker/models/validators.dart';

class AuthenticationController extends GetxController with Validators {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  TextEditingController get titleController => _titleController;
  final TextEditingController _contentController = TextEditingController();


  TextEditingController get contactController => _contactController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();


  TextEditingController get fullNameController => _fullNameController;

  TextEditingController get phoneNumber => _phoneNumber;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  TextEditingController get contentController => _contentController;
}