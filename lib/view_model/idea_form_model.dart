import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:idea_list/api/idea_api.dart';
import 'package:idea_list/model/idea.dart';
import 'package:idea_list/view_model/form_model_helper.dart';
import 'package:idea_list/view_model/idea_list_model.dart';

class IdeaFormModel extends ChangeNotifier with FormModelHelper {
  final IdeaListModel ideaListModel;
  final FirebaseUser authUser;
  final IdeaApi ideaApi;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Idea _idea;
  bool isSubmitting = false;
  bool isEditMode = false;

  IdeaFormModel({this.ideaListModel, this.authUser, this.ideaApi});

  void checkEditModeAndPopulate(Idea idea) {
    if (idea != null) {
      isEditMode = true;
      _idea = idea;
      _populateFields(idea);
    } else {
      isEditMode = false;
    }
  }

  void _populateFields(Idea idea) {
    titleController.text = idea.title;
    contentController.text = idea.content;
  }

  Future<void> submitButtonPressed() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    try {
      isSubmitting = true;
      notifyListeners();

      if (isEditMode) {
        await _handleUpdate();
      } else {
        await _handleCreate();
      }

      inSuccess.add(true);
    } catch (e) {
      inError.add(e.message);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  Future<void> _handleCreate() async {
    final idea = Idea(
      title: titleController.text,
      content: contentController.text,
      userId: authUser.uid,
    );
    Idea newIdea = await ideaApi.create(idea);
    ideaListModel.prependList(newIdea);
  }

  Future<void> _handleUpdate() async {
    _idea.title = titleController.text;
    _idea.content = contentController.text;
    Idea updatedIdea = await ideaApi.update(_idea);
    ideaListModel.updateListItem(updatedIdea);
  }

  @override
  void dispose() {
    super.dispose();
    disposeFormStateHelper();
    titleController.dispose();
    contentController.dispose();
  }
}
