class CategoriesModel {
  late int id;
  late String name;
  late String description;
  late String icon;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'] ?? 'images/sh.png';
  }
} //end of model
