class City {
  final String city;
  final double len;
  final double lene;

  City(this.city, this.len, this.lene);

  City.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        len = json['len'],
        lene = json['lene'];

  Map<String, dynamic> toJson() => {
        'city': city,
        'len': len,
        'lene': lene,
      };
}
