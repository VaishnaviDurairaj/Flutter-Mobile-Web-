import 'package:get/get.dart';
import '../models/object_model.dart';
import '../services/api_service.dart';

class ObjectController extends GetxController {
  final ApiService _apiService = Get.find();

  var objects = <ObjectModel>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  final int pageSize = 20;

  void fetchObjects({bool loadMore = false}) async {
    if (!loadMore) {
      isLoading(true);
      objects.clear();
      page.value = 1;
    }
    try {
      final list = await _apiService.getObjects(page: page.value, limit: pageSize);
      objects.addAll(list);
      page.value++;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteObject(String id) async {
    final prev = List.of(objects);
    objects.removeWhere((o) => o.id == id);
    try {
      await _apiService.deleteObject(id);
    } catch (e) {
      objects.assignAll(prev);
      Get.snackbar('Error', e.toString());
    }
  }
}
