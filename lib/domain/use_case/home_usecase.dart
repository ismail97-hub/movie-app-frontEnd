
import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void,HomeData> {
  Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure,HomeData>> execute(void input) async{
    return await _repository.home();
  }

  
}