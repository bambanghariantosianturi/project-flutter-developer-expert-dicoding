import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchTvSeriesState {}

class SearchLoading extends SearchTvSeriesState {}

class SearchError extends SearchTvSeriesState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchTvSeriesState {
  final List<TvSeries> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
