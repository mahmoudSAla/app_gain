


import 'package:appgain/core/base/base_response.dart';
import 'package:appgain/core/base/base_usecase.dart';
import 'package:appgain/data_layer/datasource/remote/exception/error_widget.dart';
import 'package:appgain/domain_layer/repository/question_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllQuestionsUseCase implements BaseUseCase<BaseResponse , QuestionParamters>{
  final QuestionAnswerRepository questionAnswerRepository ;

  GetAllQuestionsUseCase(this.questionAnswerRepository);
  @override
  Future<Either<ErrorModel, BaseResponse>> call(QuestionParamters parameters) async{
    final result = await questionAnswerRepository.getAllQuestions(page: parameters.page) ;
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> callTest(QuestionParamters parameters)  async {
    final result = await questionAnswerRepository.getAllQuestions(page: parameters.page) ;
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}


class QuestionParamters extends Equatable{

  final int page ;

  const QuestionParamters({required this.page});
  @override
  // TODO: implement props
  List<Object?> get props =>[page];
}