import 'package:app_front_talearnt/data/model/param/readNotification_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';

class NotificationRepository {
  final DioService dio;

  NotificationRepository(this.dio);

  Future<Either<Failure, List<dynamic>>> getNotification() async {
    final result = await dio.get(ApiConstants.getNotification, null, null);
    return result.fold((failure) => left(failure), (response) {
      return right(response['data']);
    });
  }

  Future<Either<Failure, Success>> readNotification(
      ReadnotificationParam body) async {
    final result = await dio.put(
      ApiConstants.readNotification,
      body.toJson(),
    );
    return result.fold(left, (response) => right(Success.fromJson(response)));
  }
}
