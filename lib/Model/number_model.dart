class Number{
  String number;
  String id;

  Number({required this.number, required this.id});
  
  static Number fromJson(Map<String, dynamic> json) =>
      Number(number: json["num"], id: json["id"]);
}