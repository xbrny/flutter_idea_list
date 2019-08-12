import 'package:flutter/material.dart';
import 'package:idea_list/constant/theme.dart';
import 'package:idea_list/root_provider.dart';
import 'package:idea_list/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Idealist',
        theme: kIdeaTheme,
        initialRoute: Router.initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
