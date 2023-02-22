import 'package:aplikasi_mini_facebook/models/postingan_mdl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class PostinganProvider extends ChangeNotifier {
  final _dpostingan = <PostinganMdl>[];
  var _isLoading = false;

  List<PostinganMdl> get dpostingan => _dpostingan;
  bool get isLoading => _isLoading;

  final CollectionReference _postinganCollection =
  FirebaseFirestore.instance.collection('postingan');

  Future<void> onBuild() async {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    final response = await _postinganCollection.get();
    final datas = response.docs;

    _dpostingan.clear();
    for (final data in datas) {
      final jsonMap = data.data() as Map<String, dynamic>?;
      if (jsonMap != null) {
        dpostingan.add(
          PostinganMdl.fromMap(
            id: data.id,
            map: jsonMap,
          ),
        );
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addData({required PostinganMdl postingan}) async {
    // add data to firebase
    _loadingAndNotifyListenerWrapper(
          () async => await _postinganCollection.add(
        postingan.toMap(),
      ),
    );
  }

  Future<void> updateData({
    required PostinganMdl postingan,
  }) async {
    _loadingAndNotifyListenerWrapper(
          () async => await _postinganCollection.doc(postingan.id).update(
        postingan.toMap(),
      ),
    );
    fetchData();
  }

  Future<void> deleteData({required String id}) async {
    _loadingAndNotifyListenerWrapper(
          () async => await _postinganCollection.doc(id).delete(),
    );
  }

  Future<void> _loadingAndNotifyListenerWrapper(AsyncCallback callback) async {
    _isLoading = true;
    notifyListeners();
    await callback.call();
    _isLoading = false;
    notifyListeners();
    fetchData();
  }
}
