import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/router.dart';
import 'package:idea_list/view_model/auth_model.dart';
import 'package:idea_list/widget/logo_icon.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);
    Future.delayed(Duration(milliseconds: 0), () async {
      if (await authModel.getAuthUser() == null) {
        Navigator.pushReplacementNamed(context, Router.userLogin);
      } else {
        Navigator.pushReplacementNamed(context, Router.ideaList);
      }
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: kAppLinearGradient,
        ),
        child: Hero(tag: 'logo', child: LogoIcon()),
      ),
    );
  }
}
