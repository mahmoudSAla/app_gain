import 'package:appgain/domain_layer/Entities/qustion_answer.dart';

class QuestionAnswerModel extends QuestionAnswer {
  const QuestionAnswerModel(
      {required super.tags,
      required super.owner,
      required super.isAnswered,
      required super.viewCount,
      required super.answerCount,
      required super.link,
      required super.title, required super.score});

  factory QuestionAnswerModel.fromJson(Map<String, dynamic>? json) =>
      QuestionAnswerModel(
          tags: json?['tags'],
          owner: Owner.fromJson(json?['owner']),
          isAnswered: json?['is_answered'],
          viewCount: json?['view_count'],
          answerCount: json?['answer_count'],
          link: json?['link'],
          title: json?['title'], score: json?['score']);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tags'] = tags;
    data['owner'] = owner.toJson();
    data['is_answered'] = isAnswered;
    data['view_count'] = viewCount;
    data['answer_count'] = answerCount;
    data['score'] = score;

    data['link'] = link;
    data['title'] = title;
    return data;
  }
}


