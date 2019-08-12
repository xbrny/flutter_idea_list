import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/constant/theme.dart';
import 'package:idea_list/router.dart';
import 'package:idea_list/view_model/login_model.dart';
import 'package:idea_list/widget/button_with_loading.dart';
import 'package:idea_list/widget/logo_icon.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final loginModel = Provider.of<LoginModel>(context, listen: false);

    loginModel.error$.listen((error) {
      if (error != null) {
        scaffoldKey.currentState
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(error)),
          );
      }
    });

    loginModel.success$.listen((isSuccess) {
      if (isSuccess) {
        Navigator.pushReplacementNamed(context, Router.ideaList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);

    return Scaffold(
      key: scaffoldKey,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: boxConstraints.maxHeight),
            decoration: BoxDecoration(
              gradient: kAppLinearGradient,
            ),
            padding: EdgeInsets.all(24),
            child: IntrinsicHeight(child: buildForm(loginModel)),
          ),
        );
      }),
    );
  }

  Widget buildForm(LoginModel loginModel) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context)
            .textTheme
            .copyWith()
            .apply(bodyColor: Colors.white),
        inputDecorationTheme: kInputDecorationThemeOnDarkBg,
      ),
      child: Form(
        key: loginModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: kSpaceSuperLarge),
                  Hero(tag: 'logo', child: LogoIcon()),
                  SizedBox(height: kSpaceExtraSmall),
                  Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(height: kSpaceExtraSmall),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Cannot be empty' : null,
                    controller: loginModel.emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Cannot be empty' : null,
                    controller: loginModel.passwordController,
                  ),
                  ForgotPasswordLink(),
                ],
              ),
            ),
            ButtonWithLoading(
              onPressed: loginModel.isSubmitting
                  ? null
                  : loginModel.submitButtonPressed,
              label: 'Login',
              isLoading: loginModel.isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSpaceExtraSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RawMaterialButton(
            shape: RoundedRectangleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
            constraints: BoxConstraints(),
            onPressed: () {},
            child: Text(
              'Forgot password'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 11),
            ),
          ),
          RawMaterialButton(
            shape: RoundedRectangleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
            constraints: BoxConstraints(),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Router.userRegister);
            },
            child: Text(
              'Register'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
