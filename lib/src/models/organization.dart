// To parse this JSON data, do
//
//     final organization = organizationFromJson(jsonString);

import 'dart:convert';

Organization organizationFromJson(String str) =>
    Organization.fromJson(json.decode(str));

String organizationToJson(Organization data) => json.encode(data.toJson());

class Organization {
  Organization({
    this.name,
    this.numTeams,
    this.numUsers,
    this.owner,
  });

  String? name;
  int? numTeams;
  int? numUsers;
  String? owner;

  factory Organization.fromJson(Map<dynamic, dynamic> json) => Organization(
        name: json["name"],
        numTeams: json["numTeams"],
        numUsers: json["numUsers"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "numTeams": numTeams,
        "numUsers": numUsers,
        "owner": owner,
      };
}
