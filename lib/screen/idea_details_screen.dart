import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/model/idea.dart';
import 'package:idea_list/router.dart';
import 'package:idea_list/widget/confirm_deletion_alert.dart';
import 'package:idea_list/widget/gradient_container.dart';
import 'package:idea_list/widget/line_close_button.dart';
import 'package:line_icons/line_icons.dart';

class IdeaDetailsScreen extends StatelessWidget {
  final Idea idea;

  const IdeaDetailsScreen({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatDate(idea.createdAt,
        ['dd', ' ', 'MM', ' ', 'yy', ', ', 'HH', ':', 'nn', ' ', 'am']);

    return Scaffold(
      body: LayoutBuilder(builder: (context, boxConstraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: boxConstraint.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildHeaderSection(context, formattedDate),
                  Expanded(child: _buildContentSection(context)),
                  Padding(
                    padding: const EdgeInsets.all(kSpaceSmall),
                    child: _buildDeleteButton(context),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  GradientContainer _buildHeaderSection(
      BuildContext context, String formattedDate) {
    return GradientContainer(
      padding: EdgeInsets.only(
        left: kSpaceSmall,
        right: kSpaceSmall,
        top: kSpaceSmall,
        bottom: kSpaceLarge,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LineCloseButton(
                  iconData: LineIcons.arrow_left,
                ),
                IconButton(
                  icon: Icon(
                    LineIcons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Router.ideaCreate,
                      arguments: idea,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: kSpaceMedium),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kSpaceSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      idea.title,
                      style: Theme.of(context).textTheme.headline.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  SizedBox(height: kSpaceSmall),
                  Text(
                    formattedDate.toUpperCase(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kSpaceSmall,
        vertical: kSpaceLarge,
      ),
      padding: EdgeInsets.all(kScreenPadding),
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
      child: Text(
        idea.content,
        style: Theme.of(context).textTheme.body1.copyWith(
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        bool isDeleted = await showDialog(
          context: context,
          builder: (context) {
            return ConfirmDeletionAlert(idea: idea);
          },
        );
        if (isDeleted) {
          Navigator.pop(context);
        }
      },
      child: Text(
        'Delete',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
