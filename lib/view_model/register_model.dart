import 'package:flutter/material.dart';
import 'package:idea_list/api/user_api.dart';
import 'package:idea_list/view_model/form_model_helper.dart';

class RegisterModel extends ChangeNotifier with FormModelHelper {
  final UserApi userApi;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSubmitting = false;

  RegisterModel(this.userApi);

  submitButtonPressed() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    isSubmitting = true;
    notifyListeners();

    try {
      await userApi.register(
        usernameController.text,
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
