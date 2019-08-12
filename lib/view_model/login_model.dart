import 'package:flutter/material.dart';
import 'package:idea_list/api/user_api.dart';
import 'package:idea_list/view_model/form_model_helper.dart';

class LoginModel extends ChangeNotifier with FormModelHelper {
  final UserApi userApi;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'bani@email.com');
  final passwordController = TextEditingController(text: 'bani1234');

  bool isSubmitting = false;

  LoginModel(this.userApi);

  submitButtonPressed() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    isSubmitting = true;
    notifyListeners();

    try {
      await userApi.login(
        emailController.text,
        passwordController.text,
      );
      inSuccess.add(true);
    } catch (e) {
      print(e);
      inError.add(e.message);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeFormStateHelper();
    emailController.dispose();
    passwordController.dispose();
  }
}
