class SignUpRequest {
  String username;

  String password;

  String deviceType;

  String ip;

  String country;

  String region;

  String regionName;

  String city;

  String zip;

  double latitude;

  double longitude;

  String timezone;

  String isp;
  
  SignUpRequest(
    this.username,
    this.password,
    this.deviceType,
    this.ip,
    this.country,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.latitude,
    this.longitude,
    this.timezone,
    this.isp,
  );
}
