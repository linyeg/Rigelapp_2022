//The Order Doesn't Matter
class Product {
  final int? id;
  final String title;
  final String description;
  final String category;
  final int ranking;
  final double price;
  final String calories;
  final String aditives;
  final String vitamines;
  final String imagepath;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.ranking,
      required this.price,
      required this.calories,
      required this.aditives,
      required this.vitamines,
      required this.imagepath});

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      ranking: json['ranking'],
      price: json['price'].toDouble(),
      calories: json['calories'],
      aditives: json['aditives'],
      vitamines: json['vitamines'],
      imagepath: json['imagepath']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category.toLowerCase(),
      'ranking': ranking,
      'price': price,
      'calories': calories,
      'aditives': aditives,
      'vitamines': vitamines,
      'imagepath': imagepath,
    };
  }
}