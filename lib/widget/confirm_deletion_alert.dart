import 'package:flutter/material.dart';
import 'package:idea_list/model/idea.dart';
import 'package:idea_list/view_model/idea_list_model.dart';
import 'package:provider/provider.dart';

class ConfirmDeletionAlert extends StatelessWidget {
  const ConfirmDeletionAlert({
    Key key,
    @required this.idea,
  }) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    return Consumer<IdeaListModel>(builder: (context, ideaListModel, __) {
      return AlertDialog(
        title: Text('Confirm delete'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () async {
              await ideaListModel.delete(idea.id);
              Navigator.pop(context, true);
            },
            child: buildDeleteButton(ideaListModel),
          ),
        ],
      );
    });
  }

  buildDeleteButton(model) {
    if (model.isActionLoading) {
      return SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
        height: 18,
        width: 18,
      );
    } else {
      return Text(
        'Delete',
        style: TextStyle(color: Colors.red),
      );
    }
  }
}
