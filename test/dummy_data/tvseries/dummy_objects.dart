import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final tTvSeriesModel = TvSeriesModel(
  posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  popularity: 29.780826,
  id: 1399,
  backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
  voteAverage: 7.91,
  overview:
      'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  firstAirDate: '2011-04-17',
  originCountry: ['US'],
  genreIds: [10765, 10759, 18],
  originalLanguage: 'en',
  voteCount: 1172,
  name: 'Game of Thrones',
  originalName: 'Game of Thrones',
);

final tTvSeries = TvSeries(
  posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  popularity: 29.780826,
  id: 1399,
  backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
  voteAverage: 7.91,
  overview:
      'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  firstAirDate: '2011-04-17',
  originCountry: ['US'],
  genreIds: [10765, 10759, 18],
  originalLanguage: 'en',
  voteCount: 1172,
  name: 'Game of Thrones',
  originalName: 'Game of Thrones',
);

final tTvSeriesResponse = TvSeriesDetailResponse(
  backdropPath: 'backdropPath',
  firstAirDate: '2022-10-10',
  genres: [GenreModel(id: 1, name: 'Drama')],
  homepage: 'https://google.com',
  id: 1,
  inProduction: false,
  languages: ['en'],
  lastAirDate: '2022-10-10',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 6,
  originCountry: ['US'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 369.0,
  posterPath: 'posterPath',
  seasons: [
    SeasonModel(
      airDate: '2022-10-10',
      episodeCount: 15,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 8.3,
  voteCount: 1200,
);

final tTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  firstAirDate: '2022-10-10',
  genres: [Genre(id: 1, name: 'Drama')],
  id: 1,
  lastAirDate: '2022-10-10',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 6,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [
    Season(
      airDate: '2022-10-10',
      episodeCount: 15,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 8.3,
  voteCount: 1200,
);

final tTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final tTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final tWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
