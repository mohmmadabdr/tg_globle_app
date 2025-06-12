class CityRestaurantModel {
  final String localizedName;
  final int locationId;
  final String documentId;
  CityRestaurantModel({
    required this.localizedName,
    required this.locationId,
    required this.documentId,
  });

  factory CityRestaurantModel.fromJson(Map<String, dynamic> json) {
    return CityRestaurantModel(
      localizedName: json['localizedName'] ?? '',
      locationId: json['locationId'] ?? 0,
      documentId: json['documentId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localizedName': localizedName,
      'locationId': locationId,
      'documentId': documentId,
    };
  }
}
