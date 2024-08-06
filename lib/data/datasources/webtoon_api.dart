import 'package:dio/dio.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_detail_model.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_episode_model.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_model.dart';

class WebtoonApi {
  static const String baseUrl =
      "http://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final dio = Dio();
    List<WebtoonModel> webtoonInstances = [];
    final response = await dio.get('$baseUrl/$today');

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = response.data;
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromMap(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final dio = Dio();
    final response = await dio.get('$baseUrl/$id');
    if (response.statusCode == 200) {
      return WebtoonDetailModel.fromMap(response.data);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final dio = Dio();
    List<WebtoonEpisodeModel> episodes = [];
    final response = await dio.get('$baseUrl/$id/episodes');
    if (response.statusCode == 200) {
      for (var episode in response.data) {
        episodes.add(WebtoonEpisodeModel.fromMap(episode));
      }
      return episodes;
    }
    throw Error();
  }
}
