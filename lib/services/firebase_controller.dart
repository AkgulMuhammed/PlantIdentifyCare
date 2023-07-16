import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:plant_identify_care/models/model_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;

class FirebaseController extends GetxController {
  List<ModelFirebase> comeToFlowers = [];
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('flowers_detail').get();

      comeToFlowers = snapshot.docs
          .map((doc) => ModelFirebase.fromJson(doc.data()))
          .toList();

      isLoading.value = false;

      log("gelen Task  length : ${comeToFlowers.length}");
      log("gelen Task   : $comeToFlowers");
    } catch (e) {
      log("error :  $e");
    }
  }

  Future<String> getImageURL(String imagePath) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    String downloadURL = await storage.refFromURL(imagePath).getDownloadURL();
    return downloadURL;
  }
}
