import 'dart:io';

import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:retrofit/retrofit.dart';

part 'web_service.g.dart';

class WebService {
  static const _baseUrl = '';
  static const _profileId = ; // intentionally left empty

  final RestClient _client;

  WebService() : _client = _createClient();

  Future<List<Comic>> getComics() async {
    final cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);

    final comics = await _client.getComics(cacheOptions);
    return comics;
  }

  Future<bool> updateIssue(Issue issue, String summary) async {
    final response = await _client.updateIssue(issue.id, summary);
    return response?.response?.statusCode == HttpStatus.ok;
  }

  Future<bool> updateIssueSettings(Issue issue, bool read) async {
    final response = await _client.updateIssueSettings(issue.id, read ? 1 : 0);
    return response?.response?.statusCode == HttpStatus.ok;
  }

  static _createClient() {
    final dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: {'ProfileID': _profileId},
    ));

    dio.transformer = FlutterTransformer();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: _baseUrl)).interceptor);

    final client = RestClient(dio);
    return client;
  }
}

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/comics')
  Future<List<Comic>> getComics(@DioOptions() Options options);

  @PATCH('/issues/{id}')
  @FormUrlEncoded()
  Future<HttpResponse<Issue>> updateIssue(@Path() int id, @Field() String summary);

  @PUT('/issues/{id}/settings')
  @FormUrlEncoded()
  Future<HttpResponse<Issue>> updateIssueSettings(@Path() int id, @Field() int read);
}
