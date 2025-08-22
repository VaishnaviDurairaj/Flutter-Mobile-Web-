import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/object_model.dart';

class ApiService {
  final String baseUrl = 'https://api.restful‑api.dev/objects';

  Future<List<ObjectModel>> getObjects({int page = 1, int limit = 20}) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((e) => ObjectModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load objects');
  }

  Future<ObjectModel> getObjectDetail(String id) async {
    final resp = await http.get(Uri.parse('$baseUrl/$id'));
    if (resp.statusCode == 200) {
      return ObjectModel.fromJson(json.decode(resp.body));
    }
    throw Exception('Failed to load detail');
  }

  Future<ObjectModel> createObject(ObjectModel obj) async {
    final resp = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obj.toJson()),
    );
    if (resp.statusCode == 201) {
      return ObjectModel.fromJson(json.decode(resp.body));
    }
    throw Exception('Failed to create object');
  }

  Future<ObjectModel> updateObject(ObjectModel obj) async {
    final resp = await http.put(
      Uri.parse('$baseUrl/${obj.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obj.toJson()),
    );
    if (resp.statusCode == 200) {
      return ObjectModel.fromJson(json.decode(resp.body));
    }
    throw Exception('Failed to update object');
  }

  Future<void> deleteObject(String id) async {
    final resp = await http.delete(Uri.parse('$baseUrl/$id'));
    if (resp.statusCode != 204) {
      throw Exception('Failed to delete object');
    }
  }
}
