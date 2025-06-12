class CityHotelModel {
  final String title;
  final int geoId;
  final String documentId;
  final String trackingItems;
  final String secondaryText;

  CityHotelModel({
    required this.title,
    required this.geoId,
    required this.documentId,
    required this.trackingItems,
    required this.secondaryText,
  });

  factory CityHotelModel.fromJson(Map<String, dynamic> json) {
    return CityHotelModel(
      title: json['title'] ?? '',
      geoId: json['geoId'] ?? 0,
      documentId: json['documentId'] ?? '',
      trackingItems: json['trackingItems'] ?? '',
      secondaryText: json['secondaryText'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'geoId': geoId,
      'documentId': documentId,
      'trackingItems': trackingItems,
      'secondaryText': secondaryText,
    };
  }
}
