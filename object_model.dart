class ObjectModel {
  final String id;
  final String name;
  final Map<String, dynamic> data;

  ObjectModel({required this.id, required this.name, required this.data});

  factory ObjectModel.fromJson(Map<String, dynamic> json) => ObjectModel(
        id: json['id'],
        name: json['name'],
        data: json['data'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'data': data,
      };
}
