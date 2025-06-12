class CityRentalCarsModel {
  final String localizedName;
  final int locationId;
  CityRentalCarsModel({required this.localizedName, required this.locationId});

  factory CityRentalCarsModel.fromJson(Map<String, dynamic> json) {
    return CityRentalCarsModel(
      localizedName: json['localizedName'] ?? '',
      locationId: json['locationId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'localizedName': localizedName, 'locationId': locationId};
  }
}
