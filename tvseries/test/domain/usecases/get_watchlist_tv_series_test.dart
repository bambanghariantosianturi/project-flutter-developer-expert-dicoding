import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_series.dart';
import '../../../../core/test/dummy_data/tvseries/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  final tTvSeriesList = [tTvSeries];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeriesList));
  });
}
