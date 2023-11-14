

import 'package:appgain/base_injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation_layer/logic/questions_cubit.dart';


class GenerateMultiBloc extends StatelessWidget {
  final Widget child;

  const GenerateMultiBloc({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:   [
        BlocProvider(create: (ctx)=> QuestionsCubit(getIt())) , 
      ],
      child: child,
    );
  }
}
