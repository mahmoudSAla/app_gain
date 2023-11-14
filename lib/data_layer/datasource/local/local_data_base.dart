



import 'dart:convert';

import 'package:appgain/domain_layer/Entities/qustion_answer.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/qustion_asnwer_model.dart';

class DataBaseHandler {
  Future<Database> initializeDB() async {
    String databasesPath = await getDatabasesPath();


    return openDatabase(
      'appgaindb.db',
      onCreate: (database, version) async {

        await database.execute(
            """CREATE TABLE  question(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                tags TEXT NOT NULL,
                owner TEXT NOT NULL,
                is_answered TEXT NOT NULL,
                view_count TEXT NOT NULL,
                answer_count TEXT NOT NULL,
                title TEXT NOT NULL,
                score TEXT NOT NULL)
              """);
      },
      version: 1,
    );
  }



  Future<int> insertQuestions(List<QuestionAnswerModel> questions) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var question in questions) {
      Map<String , dynamic> data = {
        "tags" : json.encode(question.tags) ,
        "owner" : json.encode(question.owner) ,
        "is_answered": json.encode(question.isAnswered) ,
        "view_count" : json.encode( question.viewCount) ,
        "answer_count" : json.encode(question.answerCount) ,
        "title" : question.title ,
        "score" : question.score

      };
      result = await db.insert('question', data);
    }
    return result;
  }

  Future<List<QuestionAnswerModel>> retrieveQuestions() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('question',);
    List<QuestionAnswerModel> newList = [];
    for(var question in queryResult){
      print(json.decode(question['tags'].toString()).runtimeType);
        newList.add(QuestionAnswerModel(
          tags: json.decode(question['tags'].toString()) ,
          score: json.decode(question['score'].toString()) ,
          answerCount: json.decode(question['answer_count'].toString()) ,
          isAnswered: json.decode(question['is_answered'].toString()) ,
          owner: Owner.fromJson(json.decode(question['owner'].toString())) ,
          title: question['title'].toString() ,
          viewCount: json.decode(question['view_count'].toString()) ,
          link: ""
        ));
    }
    return newList;
  }
}