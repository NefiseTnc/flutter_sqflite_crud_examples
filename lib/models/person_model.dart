class Person {
/*
{
  "id": "45dcs",
  "personName": "Ali",
  "phoneNumber": "05487896352"
} 
*/

  String? id;
  String? personName;
  String? phoneNumber;

  Person({
    this.personName,
    this.phoneNumber,
  });

  Person.withId({
    this.id,
    this.personName,
    this.phoneNumber,
  });

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    personName = json['personName']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['personName'] = personName;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
