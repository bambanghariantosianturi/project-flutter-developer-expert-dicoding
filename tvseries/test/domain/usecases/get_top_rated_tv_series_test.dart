import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
// import 'package:core/domain/usecases/tvseries/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv_series.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTopRatedTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of top rated tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
