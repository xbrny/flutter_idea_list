import 'package:flutter/material.dart';
import 'package:idea_list/api/idea_api.dart';
import 'package:idea_list/model/idea.dart';

class IdeaListModel extends ChangeNotifier {
  final IdeaApi ideaApi;
  List<Idea> list = [];
  bool isFetching = false;
  bool isActionLoading = false;
  String fetchError;

  IdeaListModel(this.ideaApi);

  Future<void> fetchByUser(String id) async {
    isFetching = true;
    try {
      list = await ideaApi.fetchByUser(id);
      fetchError = null;
      notifyListeners();
    } catch (e) {
      fetchError = 'Unable to fetch data';
      notifyListeners();
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  void prependList(Idea idea) {
    list = List()
      ..add(idea)
      ..addAll(list);
    notifyListeners();
  }

  void updateListItem(Idea idea) {
    list = list
        .map((listItem) => listItem.id == idea.id ? idea : listItem)
        .toList();

    notifyListeners();
  }

  void deleteFromList(String id) {
    list = list.where((listItem) => listItem.id != id).toList();
    notifyListeners();
  }

  Future<void> delete(String id) async {
    isActionLoading = true;
    notifyListeners();

    try {
      await ideaApi.delete(id);
      list = list.where((listItem) => listItem.id != id).toList();
      deleteFromList(id);
    } catch (e) {
      throw e;
    } finally {
      isActionLoading = false;
      notifyListeners();
    }
  }

  void cleanList() {
    list = List<Idea>();
  }
}
