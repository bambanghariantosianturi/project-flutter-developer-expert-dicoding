import 'package:dartz/dartz.dart';
// import 'package:core/domain/usecases/tvseries/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tv_series.dart';
import '../../../../core/test/dummy_data/tvseries/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
