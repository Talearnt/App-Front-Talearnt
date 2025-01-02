import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/keyword_category.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';

class TalearntBoardRepository {
  final DioService dio = DioService();

  Future<Either<Failure, List<KeywordCategory>>> getKeywords() async {
    final result = await dio.get(ApiConstants.getTalentCategories, null, null);
    return result.fold((failure) => left(failure), (response) {
      List<KeywordCategory> categories = List<KeywordCategory>.from(
          response['data'].map((data) => KeywordCategory.fromJson(data)));
      return right(categories);
    });
  }
}
