import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

// import '../../../../core/lib/domain/entities/tv_series.dart';
import '../../domain/usecases/get_now_playing_tv_series.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesNotifier(this.getNowPlayingTvSeries);

  var _tvSeries = <TvSeries>[];

  List<TvSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
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
