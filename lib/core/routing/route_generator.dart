

import 'package:appgain/presentation_layer/screens/question_details.dart';
import 'package:flutter/material.dart';



import '../../presentation_layer/screens/questions_screen.dart';
import 'platform_page_route.dart';
import 'routes.dart';
import 'undefined_route_screen.dart';

class RouteGenerator {
  static Route generateBaseRoute(RouteSettings settings) {
    return getRoute(settings);
  }

  static Route getRoute(RouteSettings settings) {
    if (settings.name == Routes.init) {
      return platformPageRoute(  const QuestionList());
    }
     //

    if (settings.name == Routes.questionDetails) {
      final args = settings.arguments as Map<String, dynamic>;

      return platformPageRoute(   QuestionDetailsScreen(questionAnswer: args['question'],));
    }
    
     else {
      return platformPageRoute(UndefinedRouteScreen(settings.name));
    }

    // return platformPageRoute(UndefinedRouteScreen(settings.name));
  }
}
