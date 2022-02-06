import 'package:uuid/uuid.dart';

class EditProduct {
  late String id;
  String title;
  String description;
  String imageUrl;
  double price;
  bool isFavorite;

  EditProduct({
    this.id = '',
    this.title = '',
    this.description = '',
    this.imageUrl = '',
    this.price = 0,
    this.isFavorite = false,
  }) {
    if (id.isEmpty) id = const Uuid().v4().toString();
  }

  @override
  String toString() {
    var output = StringBuffer();
    output.write("Product Details\n---------------\n");
    output.write('ID: $id\n');
    output.write('Title: $title\n');
    output.write('Description: $description\n');
    output.write('Image: $imageUrl\n');
    output.write('Price: $price\n');
    return output.toString();
  }
}
