

import 'package:appgain/core/base/base_response.dart';
import 'package:appgain/core/utils/logger.dart';
import 'package:appgain/data_layer/datasource/remote/exception/error_widget.dart';
import 'package:appgain/domain_layer/repository/question_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/services/network/network_client.dart';
import '../../core/services/network/network_info.dart';
import '../app_urls/app_url.dart';
import '../datasource/local/local_data_base.dart';

class QuestionAnswerRepositoryImp implements QuestionAnswerRepository{
  final NetworkClient networkClient ;
  final DataBaseHandler dataBaseHandler ;

  QuestionAnswerRepositoryImp(this.networkClient, this.dataBaseHandler);
  @override
  Future<Either<ErrorModel, BaseResponse>> getAllQuestions({required int page}) async {
    InternetConnectionChecker connectionChecker = InternetConnectionChecker();
    final NetworkInfoImpl networkInfo = NetworkInfoImpl(connectionChecker) ;
    String url = AppURL.getAllQuestions;
    NetworkCallType type = NetworkCallType.get;
    Map<String, dynamic> data = {};
    dataBaseHandler.initializeDB();

    if(await networkInfo.isConnected){
      Either<ErrorModel,  BaseResponse > result =
      await networkClient(url: "$url?order=asc&sort=creation&site=stackoverflow&page=$page&pagesize=4", data: data, type: type);
      return result.fold((l) => Left(l), (r){
        dataBaseHandler.insertQuestions(r.items!);

        return Right(r) ;
      }) ;
    }else{
      final localResult = await  dataBaseHandler.retrieveQuestions();
      if(localResult.isNotEmpty){
        return Right(BaseResponse(items: localResult , hasMore: false));
      }else{
        return const Left(ErrorModel(errorMessage: "No Internet Connection")) ;
      }

    }

  }

  @override
  Future<Either<ErrorModel, BaseResponse>> getAnswers({required int page, required int questionId})  async {
    String url = AppURL.getAllQuestions;
    NetworkCallType type = NetworkCallType.get;
    Map<String, dynamic> data = {};
    Either<ErrorModel,  BaseResponse > result =
        await networkClient(url: url, data: data, type: type);
    return result.fold((l) => Left(l), (r) => Right(r)) ;
  }
}