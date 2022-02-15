import 'package:movieapp/app/functions.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/data/request/request.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class SplashUseCase extends BaseUseCase<void, UserInfo> {
  Repository _repository;

  SplashUseCase(this._repository);
  
  @override
  Future<Either<Failure, UserInfo>> execute(void input) async{
    return await _repository.userInfo();
  }  
  
  Future<Either<Failure, String>> signUp(SplashUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.signUp(SignUpRequest(
        deviceInfo.identifier,
        deviceInfo.identifier,
        deviceInfo.name,
        input.ip,
        input.country,
        input.region,
        input.regionName,
        input.city,
        input.zip,
        input.latitude,
        input.longitude,
        input.timezone,
        input.isp));
  }
  
}

class SplashUseCaseInput {
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

  SplashUseCaseInput(
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
