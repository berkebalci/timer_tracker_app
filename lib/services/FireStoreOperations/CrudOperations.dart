import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_app_firebase/services/models/Note.dart';

class FireStoreCrudOperations {
  Future createNote(
      String userUID, String title, String content,) async {
    final docNote = FirebaseFirestore.instance
        .collection('users')
        .doc('$userUID')
        .collection('note1')
        .doc();
    final note = Note(title: title, content: content,);
    final json = note.toJson();
    docNote.set(json);
  }

  Stream<List<Note>> readNotes(String userUID) {
    //Bu stream yapısından zaten asenkron olduğundan dolayı async* keywordunu kullanmamız gerekiyor.
    return FirebaseFirestore.instance
        .collection('users')
        .doc('$userUID')
        .collection('note1')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) => Note.fromJson(docs.data())).toList();
    });

    //Dökümanların datalarını döndürüyor
  }
}
