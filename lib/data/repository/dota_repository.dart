import 'package:dio/dio.dart';
import 'package:new_project/data/models/repository_result.dart';

import '../models/heroesDTO.dart';

class DotaRepository {
  String url = 'https://api.opendota.com/api/';
  String apiKey = '9ae6380a-bf91-4be4-bbf5-a85173abcf73';
  final dioClient = Dio();



  Map<String, String> requestHeaders = {
    'Authorization': 'undefined',
    'X-RapidAPI-Host': 'dota-2-heroes1.p.rapidapi.com',
    'X-RapidAPI-Key': '3b2d7674a5mshf1ab25e51210bd2p17c519jsn843ec14a4157',

  };

  Future<RepositoryResult> fetchAllHeroes() async{
    /*dioClient.options.headers['Authorization'] = 'undefined';
    dioClient.options.headers['X-RapidAPI-Host'] = 'dota-2-heroes1.p.rapidapi.com';
    dioClient.options.headers['X-RapidAPI-Key'] = '3b2d7674a5mshf1ab25e51210bd2p17c519jsn843ec14a4157';
*/
    //var uri = Uri.parse('https://dota-2-heroes1.p.rapidapi.com/Dota/Heroes');
    //var res = await dioClient.get('https://dota-2-heroes1.p.rapidapi.com/Dota/Heroes');
    try {
      Response response = await dioClient.get('https://api.opendota.com/api/heroes', queryParameters: {'api_key': apiKey});

      var heroList = (response.data as List)
          .map((jsonStr) => DotaHero.fromJson(jsonStr))
          .toList();

      print(' in repository list size = ${heroList.length}');
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

}

