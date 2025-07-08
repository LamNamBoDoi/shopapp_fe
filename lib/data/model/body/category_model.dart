class CategoryModel {
  int? id;
  String? name;
  String? thumbnail;
  CategoryModel({this.id, this.name, this.thumbnail});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'], name: json['name'], thumbnail: json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'thumbnail': thumbnail};
  }
}
