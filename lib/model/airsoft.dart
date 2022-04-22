class Airsoft{
  late int id;
  late String name;
  late String image;
  late int price;
  late int qty;

  Airsoft({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty
  });

  factory Airsoft.fromMap(var maps)=>Airsoft(
      id: maps["id"],
      name: maps["name"],
      image: maps["image"],
      price: maps["price"],
      qty: maps["qty"]
  );

  Map<String,dynamic>toJson()=>{
    "id":id,
    "name":name,
    "image":image,
    "price":price,
    "qty":qty
  };
}