import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/keyword_category.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';
import '../model/param/my_talent_keywords_param.dart';

class TalentBoardRepository {
  final DioService dio;

  TalentBoardRepository(this.dio);

  // Future<Either<Failure, List<KeywordCategory>>> getKeywords() async {
  //   final result = await dio.get(ApiConstants.getTalentCategories, null, null);
  //   return result.fold((failure) => left(failure), (response) {
  //     List<KeywordCategory> categories = List<KeywordCategory>.from(
  //         response['data'].map((data) => KeywordCategory.fromJson(data)));
  //     return right(categories);
  //   });
  // }

  Future<Either<Failure, Success>> setMyKeywords(
      MyTalentKeywordsParam body) async {
    final result = await dio.post(
        ApiConstants.setMyTalentKeywordsUrl, body.toJson(), null);
    return result.fold(left, (response) => right(Success.fromJson(response)));
  }
}
