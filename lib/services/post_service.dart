import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  final FirebaseFirestore firebaseFirestore;

  PostService(this.firebaseFirestore);

  Future<QuerySnapshot> getPosts(String idUser) {
    return firebaseFirestore
        .collection('posts')
        .doc(idUser)
        .collection(idUser)
        .orderBy('createdAt', descending: true)
        .limit(4)
        .get();
  }

  Future<QuerySnapshot> loadMorePosts(
    String idUser,
    DocumentSnapshot lastPost,
  ) {
    return firebaseFirestore
        .collection('posts')
        .doc(idUser)
        .collection(idUser)
        .orderBy('createdAt', descending: true)
        .limit(4)
        .startAfterDocument(lastPost)
        .get();
  }
}
