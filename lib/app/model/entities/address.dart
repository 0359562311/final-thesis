class Address {
  final int? id;
  final String? city;
  final String? district;
  final String? ward;
  final String? detail;
  final num? latitude;
  final num? longitude;

  Address({
    this.id,
    this.city,
    this.district,
    this.ward,
    this.detail,
    this.latitude,
    this.longitude,
  });

  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        city = json['city'] as String?,
        district = json['district'] as String?,
        ward = json['ward'] as String?,
        detail = json['detail'] as String?,
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'district': district,
        'ward': ward,
        'detail': detail,
        'latitude': latitude,
        'longitude': longitude
      };
}
