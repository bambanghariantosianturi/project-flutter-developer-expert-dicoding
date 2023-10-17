import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_popular_tv_series.dart';

class PopularTvSeriesNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesNotifier(this.getPopularTvSeries);

  var _tvSeries = <TvSeries>[];

  List<TvSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _state = RequestState.Loaded;
        _tvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
