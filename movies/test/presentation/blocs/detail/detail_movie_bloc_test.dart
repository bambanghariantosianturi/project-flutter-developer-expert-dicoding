import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/detail/detail_movie_bloc.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetDetailMovie mockGetDetailMovie;
  late MockGetRecommendationMovies mockGetRecommendationMovies;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetDetailMovie = MockGetDetailMovie();
    mockGetRecommendationMovies = MockGetRecommendationMovies();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    detailMovieBloc = DetailMovieBloc(
      getMovieDetail: mockGetDetailMovie,
      getMovieRecommendations: mockGetRecommendationMovies,
      saveWatchlistMovie: mockSaveWatchlistMovie,
      removeWatchlistMovie: mockRemoveWatchlistMovie,
      getWatchListStatusMovie: mockGetWatchListStatusMovie,
    );
  });

  const tId = 1;

  group('Get Detail Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded, RecomendationLoading, RecommendationLoaded] when get detail movie and recommendation movies success',
      build: () {
        when(mockGetDetailMovie.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(FetchDetailMovie(tId)),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Loaded,
          movieRecommendations: testMovieList,
        ),
      ],
      verify: (_) {
        verify(mockGetDetailMovie.execute(tId));
        verify(mockGetRecommendationMovies.execute(tId));
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [DetailMovieError] when get detail movie failed',
      build: () {
        when(mockGetDetailMovie.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(FetchDetailMovie(tId)),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetDetailMovie.execute(tId));
        verify(mockGetRecommendationMovies.execute(tId));
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded, RecommendationEmpty] when get recommendation movies empty',
      build: () {
        when(mockGetDetailMovie.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => const Right([]));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(FetchDetailMovie(tId)),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Empty,
        ),
      ],
      verify: (_) {
        verify(mockGetDetailMovie.execute(tId));
        verify(mockGetRecommendationMovies.execute(tId));
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [DetailMovieLoading, RecomendationLoading, DetailMovieLoaded, RecommendationError] when get recommendation movies failed',
      build: () {
        when(mockGetDetailMovie.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(FetchDetailMovie(tId)),
      expect: () => [
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetDetailMovie.execute(tId));
        verify(mockGetRecommendationMovies.execute(tId));
      },
    );
  });

  group('Load Watchlist Status Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit [WatchlistStatus] is true',
      build: () {
        when(mockGetWatchListStatusMovie.execute(tId))
            .thenAnswer((_) async => true);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusMovie(tId)),
      expect: () => [
        DetailMovieState.initial().copyWith(isAddedToWatchlist: true),
      ],
      verify: (_) => verify(mockGetWatchListStatusMovie.execute(tId)),
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit [WatchlistStatus] is false',
      build: () {
        when(mockGetWatchListStatusMovie.execute(tId))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusMovie(tId)),
      expect: () => [
        DetailMovieState.initial().copyWith(isAddedToWatchlist: false),
      ],
      verify: (_) => verify(mockGetWatchListStatusMovie.execute(tId)),
    );
  });

  group('Added To Watchlist Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success added to watchlist',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
        ),
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovie.execute(testMovieDetail.id));
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [WatchlistMessage] when failed added to watchlist',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        DetailMovieState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovie.execute(testMovieDetail.id));
      },
    );
  });

  group('Remove From Watchlist Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success removed from watchlist',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistMovie(testMovieDetail)),
      expect: () => [
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovie.execute(testMovieDetail.id));
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Shoud emit [WatchlistMessage] when failed removed from watchlist',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistMovie(testMovieDetail)),
      expect: () => [
        DetailMovieState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovie.execute(testMovieDetail.id));
      },
    );
  });
}
