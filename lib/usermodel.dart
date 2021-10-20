class Usermodel {
  int? id;
  String? name;
  String? number;
  String? address;

  Usermodel({this.id, this.name, this.number, this.address});

  factory Usermodel.fromMap(Map<String, dynamic> data) => Usermodel(
      id: data['id'],
      name: data['name'],
      number: data['number'],
      address: data['address']);

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "number": number, "address": address};
}
