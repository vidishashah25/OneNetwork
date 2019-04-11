class Look{
    String error;
    String msg;
    Intrests intrests;
    Look({this.error,this.msg,this.intrests});

    factory Look.fromJson(Map<String,dynamic> json){
        return Look(
            error: json['error'],
            msg: json['message'],
          intrests: Intrests.fromJson(json['interests']),
        );
    }
}

class Intrests {
  String category_id;
  String categoryname;
  int count;
  IntrestsArray intrestsArray;
  Intrests({this.category_id,this.categoryname,this.count,this.intrestsArray});
  factory Intrests.fromJson(Map<String, dynamic> json){
      return Intrests(
          category_id:json['category_id'],
          categoryname:json['category_name'],
          count:json['count'],
          intrestsArray:IntrestsArray.fromJson(json['interests_array']),
      );
  }
}

class IntrestsArray{
      int id;
      String name;
      IntrestsArray({this.id,this.name});

  factory IntrestsArray.fromJson(Map<String,dynamic> json){
      return IntrestsArray(
          id:json['id'],
          name:json['name'],
      );
  }

}