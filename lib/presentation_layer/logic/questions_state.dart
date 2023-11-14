part of 'questions_cubit.dart';

 class QuestionsState extends Equatable {
  
  final BaseState state ;
  final BaseState paginationState ;
  const QuestionsState({this.state = BaseState.initial , this.paginationState = BaseState.initial});

  QuestionsState copyWith({BaseState? state , BaseState? paginationState}){
    return QuestionsState(
      state: state ?? this.state ,
      paginationState: paginationState ?? this.paginationState
    );
  }
  @override
  List<Object> get props => [state , paginationState];
}


