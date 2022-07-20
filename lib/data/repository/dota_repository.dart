import 'package:dio/dio.dart';
import 'package:new_project/data/models/heroInfoDTO.dart';
import 'package:new_project/data/models/heroesResponseDTO.dart';
import 'package:new_project/data/models/repository_result.dart';

class DotaRepository {
  final String _url = 'https://www.dota2.com/datafeed';
  final _dioClient = Dio();

  Future<RepositoryResult> fetchAllHeroes() async {
    try {
      Response response = await _dioClient.get(
          'https://www.dota2.com/datafeed/herolist?language=english');

      var heroData = HeroesResponse.fromJson(response.data);
      var heroList = heroData.result?.data?.heroes;
      /*var heroList = (response.data as List)
          .map((jsonStr) => DotaHero.fromJson(jsonStr))
          .toList();
*/
      return RepositoryResult(success: heroList, error: null);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
      return RepositoryResult(success: null, error: e.message);
    }
  }

  Future<RepositoryResult> fetchHeroById(int idHero) async {
    try {
      Response response = await _dioClient.get('$_url/herodata', queryParameters: {'language': 'english','hero_id':idHero});

      var heroResponse  = Welcome.fromJson(response.data);
      var hero = heroResponse.result.data.heroes.first;

      return RepositoryResult(success: hero, error: null);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
      return RepositoryResult(success: null, error: e.message);
    }
  }
}
