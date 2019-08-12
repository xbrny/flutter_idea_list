import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/constant/theme.dart';
import 'package:idea_list/router.dart';
import 'package:idea_list/view_model/register_model.dart';
import 'package:idea_list/widget/button_with_loading.dart';
import 'package:idea_list/widget/logo_icon.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatefulWidget {
  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final registerModel = Provider.of<RegisterModel>(context, listen: false);

    registerModel.error$.listen((error) {
      if (error != null) {
        scaffoldKey.currentState
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(error)),
          );
      }
    });

    registerModel.success$.listen((isSuccess) {
      if (isSuccess) {
        Navigator.pushReplacementNamed(context, Router.ideaList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final registerModel = Provider.of<RegisterModel>(context);

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
            child: IntrinsicHeight(child: buildForm(registerModel)),
          ),
        );
      }),
    );
  }

  Widget buildForm(RegisterModel registerModel) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context)
            .textTheme
            .copyWith()
            .apply(bodyColor: Colors.white),
        inputDecorationTheme: kInputDecorationThemeOnDarkBg,
      ),
      child: Form(
        key: registerModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: kSpaceSuperLarge),
                  LogoIcon(),
                  SizedBox(height: kSpaceExtraSmall),
                  Text(
                    'Register',
                    style: kPageTitleTextStyle,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Cannot be empty' : null,
                    controller: registerModel.usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Cannot be empty' : null,
                    controller: registerModel.emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Cannot be empty' : null,
                    controller: registerModel.passwordController,
                  ),
                  LoginLink(),
                ],
              ),
            ),
            ButtonWithLoading(
              label: 'Register',
              onPressed: registerModel.isSubmitting
                  ? null
                  : registerModel.submitButtonPressed,
              isLoading: registerModel.isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginLink extends StatelessWidget {
  const LoginLink();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSpaceExtraSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RawMaterialButton(
            shape: RoundedRectangleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
            constraints: BoxConstraints(),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Router.userLogin);
            },
            child: Text(
              'Login'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
