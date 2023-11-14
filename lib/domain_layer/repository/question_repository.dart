

import 'package:appgain/core/base/base_response.dart';
import 'package:appgain/data_layer/datasource/remote/exception/error_widget.dart';
import 'package:dartz/dartz.dart';

abstract class QuestionAnswerRepository{


  Future<Either<ErrorModel  , BaseResponse>> getAllQuestions({required int page});
  Future<Either<ErrorModel , BaseResponse>> getAnswers({required int page  , required int questionId});
}