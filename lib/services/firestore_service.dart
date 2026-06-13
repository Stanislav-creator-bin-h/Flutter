import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _notesRef {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    return _firestore.collection('users').doc(user.uid).collection('notes');
  }

  Future<void> createNote(String title, String content) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _notesRef.add({
      'title': title,
      'content': content,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Note>> getNotes() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> updateNote(String noteId, String title, String content) async {
    await _notesRef.doc(noteId).update({
      'title': title,
      'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRef.doc(noteId).delete();
  }
}