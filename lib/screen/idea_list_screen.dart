import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/router.dart';
import 'package:idea_list/view_model/auth_model.dart';
import 'package:idea_list/view_model/idea_list_model.dart';
import 'package:idea_list/widget/gradient_container.dart';
import 'package:idea_list/widget/idea_list_item.dart';
import 'package:idea_list/widget/logo_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class IdeaListScreen extends StatefulWidget {
  @override
  _IdeaListScreenState createState() => _IdeaListScreenState();
}

class _IdeaListScreenState extends State<IdeaListScreen> {
  IdeaListModel ideaListModel;

  @override
  void initState() {
    super.initState();
    final authUser = Provider.of<FirebaseUser>(context, listen: false);
    ideaListModel = Provider.of<IdeaListModel>(context, listen: false);
    ideaListModel.fetchByUser(authUser.uid);
  }

  @override
  void dispose() {
    super.dispose();
    ideaListModel.cleanList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          GradientContainer(
            padding: EdgeInsets.all(kSpaceMedium),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      LogoIcon(
                        size: 28,
                      ),
                      SizedBox(width: kSpaceExtraSmall),
                      Text(
                        'Idea list',
                        style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  AppBarActions(),
                ],
              ),
            ),
          ),
          IdeaList()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(LineIcons.plus),
        mini: true,
        onPressed: () {
          Navigator.pushNamed(context, Router.ideaCreate);
        },
      ),
    );
  }
}

class AppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: false);

    return IconButton(
      padding: EdgeInsets.all(0),
      iconSize: 20,
      icon: Icon(
        Icons.power_settings_new,
        color: Colors.white,
      ),
      onPressed: () async {
        Navigator.pushReplacementNamed(context, Router.userLogin);
        await authModel.logout();
      },
    );
  }
}

class IdeaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<IdeaListModel>(
      builder: (_, ideaListModel, __) {
        if (ideaListModel.isFetching) {
          return Container(
            padding: EdgeInsets.all(kSpaceLarge),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        if (ideaListModel.fetchError != null) {
          return Container(
            padding: EdgeInsets.all(kSpaceLarge),
            alignment: Alignment.center,
            child: Text(ideaListModel.fetchError),
          );
        }

        final ideas = ideaListModel.list;

        if (ideas.length == 0) {
          return Container(
            padding: EdgeInsets.all(kSpaceLarge),
            alignment: Alignment.center,
            child: Text('Item is empty'),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: kSpaceLarge),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: ideas.length,
            itemBuilder: (context, index) {
              final idea = ideas[index];
              return IdeaListItem(idea: idea);
            },
          ),
        );
      },
    );
  }
}
