class Intrests{
  int id;
  String name;
  IntrestsArray intrestsArray;
  List<IntrestsArray> intrests1;
  List<IntrestsArray2> intrests2;
  Intrests({
      this.id,
      this.name,
    this.intrests1,
    this.intrests2,
    this.intrestsArray,
      });
  factory Intrests.fromJson(Map<String, dynamic> _map){
    return Intrests(
        id: _map['category_id'],
        name:_map['category_name'],
        intrestsArray: IntrestsArray.fromJson(_map['interests_array']),
    );
  }
}

class IntrestsArray {
  int id;
  String name;
  String category;
  IntrestsArray({
    this.id,
    this.name,
    this.category,
    });

  factory IntrestsArray.fromJson(Map<String , dynamic> json){
      return new IntrestsArray(
        id: json['id'],
        name: json['name'].toString(),
        category: json['category'].toString(),
      );
  }
}

class IntrestsArray2 {
  int id;
  String name;
  String category;
  IntrestsArray2({
    this.id,
    this.name,
    this.category,
  });

  factory IntrestsArray2.fromJson(Map<String , dynamic> json){
    return new IntrestsArray2(
      id: json['id'],
      name: json['name'].toString(),
      category: json['category'].toString(),
    );
  }
}