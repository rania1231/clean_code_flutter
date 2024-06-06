import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OffLineFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
