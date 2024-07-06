
class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel({this.id,
        this.name,this.image
      });

  toJson() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'image':image
    };
    return map;
  }

  CategoryModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];

  }
}


