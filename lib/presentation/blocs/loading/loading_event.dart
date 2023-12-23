import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object?> get props => [];
}

class StartLoading extends LoadingEvent {}

class FinishLoading extends LoadingEvent {}
