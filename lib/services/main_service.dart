import 'dart:io';

import 'package:project/model/character.dart';
import 'package:dio/dio.dart';

abstract class IMainService {
  Future<List<Character>?> fetchCharacters();
}

class MainService {
  final Dio _dio;
  MainService()
      : _dio = Dio(BaseOptions(baseUrl: "https://breakingbadapi.com/api/"));

  Future<List<Character>?> fetchCharacters() async {
    try {
      final response = await _dio.get(ServicePaths.characters.name);
      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;
        if (_datas is List) {
          return _datas.map((e) => Character.fromJson(e)).toList();
        }
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}

enum ServicePaths { characters }
