import 'package:appgain/core/base/base_states.dart';
import 'package:appgain/domain_layer/Entities/qustion_answer.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/utils/alerts.dart';
import '../../domain_layer/use_cases/getAllQuestionUseCase.dart';
import 'package:native_show_toast/native_show_toast.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final GetAllQuestionsUseCase getAllQuestionsUseCase ; 
  QuestionsCubit(this.getAllQuestionsUseCase) : super(const QuestionsState());




  int page = 1;
  bool hasMore = true;
  List<QuestionAnswer> qustion_answer  = [] ; 
  Future<List<QuestionAnswer>> getAllQuestion({bool isPagination = false})async{

    if(isPagination){
      emit(state.copyWith(paginationState: BaseState.loading));
    }else{
      emit(state.copyWith(state: BaseState.loading));
    }
   final result  = await getAllQuestionsUseCase.call( QuestionParamters(page: page) );

      
   return result.fold((l) {
     Alerts.showSnackBar("${l.errorMessage}") ;
     return Future.error(l);
   }, (r) {
      if(r.hasMore!){
        page = page +1 ; 
      }


        if(isPagination){
        emit(state.copyWith(paginationState: BaseState.loaded));
      }else{
        emit(state.copyWith(state: BaseState.loaded));
        NativeShowToast.showToast("Data loaded") ;
      }

    return r.items!;
      

   });
  }
}
