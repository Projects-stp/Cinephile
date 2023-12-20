import 'package:equatable/equatable.dart';

abstract class CastEvent extends Equatable {
  const CastEvent();
}

class LoadCastEvent extends CastEvent {
  final int movieId;

  const LoadCastEvent({
    required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}
