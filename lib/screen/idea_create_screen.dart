import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';
import 'package:idea_list/constant/theme.dart';
import 'package:idea_list/model/idea.dart';
import 'package:idea_list/view_model/idea_form_model.dart';
import 'package:idea_list/widget/gradient_container.dart';
import 'package:idea_list/widget/line_close_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class IdeaCreateScreen extends StatefulWidget {
  final Idea idea;

  const IdeaCreateScreen({this.idea});

  @override
  _IdeaCreateScreenState createState() => _IdeaCreateScreenState();
}

class _IdeaCreateScreenState extends State<IdeaCreateScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    final formModel = Provider.of<IdeaFormModel>(context, listen: false);

    formModel.checkEditModeAndPopulate(widget.idea);

    formModel.error$.listen((error) {
      if (error != null) {
        scaffoldKey.currentState
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(error)),
          );
      }
    });

    formModel.success$.listen((isSuccess) {
      if (isSuccess) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IdeaFormModel>(
      builder: (context, formModel, __) {
        final formKey = formModel.formKey;
        final isSubmitting = formModel.isSubmitting;
        final isEditMode = formModel.isEditMode;
        final titleController = formModel.titleController;
        final contentController = formModel.contentController;
        final submitButtonPressed = formModel.submitButtonPressed;

        return ModalProgressHUD(
          inAsyncCall: isSubmitting,
          child: Scaffold(
            key: scaffoldKey,
            body: LayoutBuilder(
              builder: (context, BoxConstraints boxConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: boxConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: buildForm(
                        formKey,
                        titleController,
                        contentController,
                        submitButtonPressed,
                        isEditMode,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Form buildForm(
      GlobalKey<FormState> formKey,
      TextEditingController titleController,
      TextEditingController contentController,
      submitButtonPressed(),
      bool isEditMode) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildHeaderSection(context, titleController, isEditMode),
          Expanded(child: _buildContentSection(context, contentController)),
          Padding(
            padding: const EdgeInsets.all(kSpaceSmall),
            child: RaisedButton(
              onPressed: submitButtonPressed,
              child: Text(isEditMode ? 'Save' : 'Create'),
              color: Theme.of(context).primaryColor,
              colorBrightness: Brightness.dark,
            ),
          )
        ],
      ),
    );
  }

  GradientContainer _buildHeaderSection(
    BuildContext context,
    TextEditingController titleController,
    bool isEditMode,
  ) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LineCloseButton(),
                SizedBox(width: kSpaceSmall),
                Text(
                  isEditMode ? 'Improvise your idea' : 'Let your idea flow',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            SizedBox(height: kSpaceMedium),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kSpaceSmall),
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: kInputDecorationThemeOnDarkBg,
                ),
                child: TextFormField(
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: Colors.white,
                      ),
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  maxLines: 2,
                  controller: titleController,
                  validator: (value) =>
                      value.isEmpty ? 'Field cannot be empty' : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(
      BuildContext context, TextEditingController contentController) {
    return Container(
      margin: EdgeInsets.fromLTRB(kSpaceSmall, kSpaceLarge, kSpaceSmall, 0),
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
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Content',
        ),
        expands: true,
        maxLines: null,
        controller: contentController,
        validator: (value) => value.isEmpty ? 'Field cannot be empty' : null,
      ),
    );
  }
}
