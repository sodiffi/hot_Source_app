class Data {
  List<Temps> temps;
  double heat_index;
  String suggestion;
  int heat_percent;

  Data(this.temps, this.heat_index, this.suggestion, this.heat_percent);

  Data.fromJson(Map<String, dynamic> json)
      : temps = List<Temps>.from(json['temps'].map((e) => Temps.fromJson(e))),
        heat_index = json['heat_index'],
        suggestion = json['suggestion'],
        heat_percent = json['heat_percent'];

  Map<String, dynamic> toJson() => {
        'temps': List<Temps>.from(temps.map((e) => e.toString())),
        'heat_index': heat_index,
        'suggestion': suggestion,
        'heat_percent': heat_percent
      };
}

class Temps {
  final DateTime time;
  final double temp;
  final double hum;

  Temps(this.time, this.temp, this.hum);

  Temps.fromJson(Map<String, dynamic> json)
      : time = DateTime.parse(json['time']),
        temp = json['temp'],
        hum = json['hum'];

  Map<String, dynamic> toJson() => {'time': time, 'temp': temp, 'hum': hum};
}
