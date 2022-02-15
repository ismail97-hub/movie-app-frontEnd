

import 'package:dartz/dartz.dart';
import 'package:movieapp/data/network/failure.dart';

abstract class BaseUseCase<In,Out> {
  Future<Either<Failure,Out>> execute(In input);
}