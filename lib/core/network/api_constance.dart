class ApiConstance {
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = '0247a25c80e36b53db4baf51cb713772';

  static String nowPlayingMoviePath =
      "$baseUrl/movie/now_playing?api_key=$apiKey";
  static String popularMoviePath = "$baseUrl/movie/popular?api_key=$apiKey";
  static String topRatedMoviePath = "$baseUrl/movie/top_rated?api_key=$apiKey";

  static String movieDetailsPath(int idMovie) =>
      "$baseUrl/movie/$idMovie?api_key=$apiKey";
  static String recommendationPath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";

  static String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => '$baseImageUrl$path';

  static String addToFavoritesPath(int accountId) =>
      "$baseUrl/account/$accountId/favorite?api_key=$apiKey";
  static String favoriteMoviesPath() =>
      "$baseUrl/account/favorite/movies?api_key=$apiKey";

  //----------------------------------------------------------------------------

// Tvs
  static String onTheAir = "$baseUrl/tv/on_the_air?api_key=$apiKey";
  static String popularTvPath = "$baseUrl/tv/popular?api_key=$apiKey";
  static String topRatedTvPath = "$baseUrl/tv/top_rated?api_key=$apiKey";
  static String tvDetailsPath(int idTv) => "$baseUrl/tv/$idTv?api_key=$apiKey";

  static String recommendationTvPath(int tvId) =>
      "$baseUrl/tv/$tvId/recommendations?api_key=$apiKey";
}
