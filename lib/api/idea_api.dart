import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idea_list/model/idea.dart';

class IdeaApi {
  CollectionReference ideaRef = Firestore.instance.collection('ideas');

  Future<List<Idea>> fetchByUser(String id) async {
    print('IdeaApi.fetchByUser');
    final snapshot = await ideaRef
        .where('userId', isEqualTo: id)
        .orderBy('createdAt', descending: true)
        .getDocuments();
    return snapshot.documents
        .map((documentSnapshot) => Idea.fromSnapshot(documentSnapshot))
        .toList();
  }

  Future<Idea> fetchById(String id) async {
    print('IdeaApi.fetchById');
    return Idea.fromSnapshot(await ideaRef.document(id).get());
  }

  Future<Idea> create(Idea idea) async {
    print('IdeaApi.create');
    final docRef = ideaRef.document();
    idea.id = docRef.documentID;
    idea.createdAt = DateTime.now();
    await docRef.setData(idea.toJson());
    return Idea.fromSnapshot(await docRef.get());
  }

  Future<Idea> update(Idea idea) async {
    print('IdeaApi.update');
    await ideaRef.document(idea.id).setData(idea.toJson(), merge: true);
    return idea;
  }

  Future<void> delete(String id) async {
    print('IdeaApi.delete');
    await ideaRef.document(id).delete();
  }
}
