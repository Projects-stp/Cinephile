import 'package:equatable/equatable.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class LoadVideosEvent extends VideosEvent {
  final int movieId;

  const LoadVideosEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
