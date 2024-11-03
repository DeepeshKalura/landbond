class NearbyPlace {
  final String name;
  final double distance;
  final String type;

  NearbyPlace({
    required this.name,
    required this.distance,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'distance': distance,
        'type': type,
      };

  factory NearbyPlace.fromJson(Map<String, dynamic> json) => NearbyPlace(
        name: json['name'],
        distance: json['distance'],
        type: json['type'],
      );
}
