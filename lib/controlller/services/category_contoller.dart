import 'package:bayoum_store_app/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  void fetchCategory() {
    _firestore
        .collection('Categories')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      categories.addAll(querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CategoryModel(data['CategoryName'], data['Image']);
      }).toList());
    });
  }
}
