import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/model/idea.dart';
import 'package:idea_list/router.dart';
import 'package:line_icons/line_icons.dart';

class IdeaListItem extends StatelessWidget {
  const IdeaListItem({
    Key key,
    @required this.idea,
  }) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatDate(idea.createdAt,
        ['dd', ' ', 'M', ' ', 'yy', ', ', 'HH', ':', 'nn', ' ', 'am']);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Router.ideaDetails,
          arguments: idea,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: kSpaceMedium,
          vertical: kSpaceExtraSmall,
        ),
        padding: EdgeInsets.all(kSpaceMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpaceExtraSmall),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    idea.title,
                    style: Theme.of(context).textTheme.headline.copyWith(
                          color: kIdeaOrange300,
                        ),
                  ),
                ),
                SizedBox(width: kSpaceExtraSmall),
              ],
            ),
            SizedBox(height: kSpaceExtraSmall),
            Text(
              formattedDate.toUpperCase(),
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}

//class ActionButtons extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.end,
//      children: <Widget>[
//        RawMaterialButton(
//          constraints: BoxConstraints(),
//          child: Icon(
//            LineIcons.edit,
//            size: 22,
//            color: Colors.grey.shade400,
//          ),
//          onPressed: () {
//            Navigator.pushNamed(
//              context,
//              Router.ideaCreate,
//              arguments: idea,
//            );
//          },
//        ),
//        RawMaterialButton(
//          constraints: BoxConstraints(),
//          child: Icon(
//            LineIcons.trash,
//            size: 22,
//            color: Colors.red.shade400,
//          ),
//          onPressed: () async {
//            showDialog(
//              context: context,
//              builder: (context) {
//                return ConfirmDeletionAlert(idea: idea);
//              },
//            );
//          },
//        ),
//      ],
//    );
//  }
//}
