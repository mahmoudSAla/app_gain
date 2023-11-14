import 'package:appgain/data_layer/models/qustion_asnwer_model.dart';
import 'package:appgain/domain_layer/Entities/qustion_answer.dart';

class BaseResponse<T> {

  List<QuestionAnswerModel>? items ;
  bool? hasMore ;
  BaseResponse({

    this.items ,
    this.hasMore
  });

   BaseResponse.fromJson(Map<String, dynamic> ?json) {

     if (json?['items'] != null) {
       items = <QuestionAnswerModel>[];
       json?['items'].forEach((v) {
         items!.add( QuestionAnswerModel.fromJson(v));
       });
     }
     hasMore = json?['has_more'];
  }

  copyWith({
    List<QuestionAnswerModel> ? items  ,
    bool ? hasMore

  }) {
    return BaseResponse(
 items: items ,
      hasMore: hasMore

    );
  }
}

