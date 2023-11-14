import 'package:equatable/equatable.dart';

class QuestionAnswer extends Equatable{

  final List<dynamic> tags ;
  final Owner owner ;
  final bool isAnswered ;
  final int viewCount  ;
  final int answerCount ;
  final String link ;
  final String title ;
  final int score ;

  const QuestionAnswer(
      { required this.tags,
      required this.owner,
      required this.isAnswered,
      required this.viewCount,
      required this.answerCount,
      required this.link,
      required this.title , required this.score});


  @override
  // TODO: implement props
  List<Object?> get props => [tags , owner , isAnswered , viewCount , answerCount , link , title , score];


}


class Owner {
  int? accountId;
  int? reputation;
  int? userId;
  String? userType;
  String? profileImage;
  String? displayName;
  String? link;

  Owner(
      {this.accountId,
        this.reputation,
        this.userId,
        this.userType,
        this.profileImage,
        this.displayName,
        this.link});

  Owner.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['reputation'] = this.reputation;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['profile_image'] = this.profileImage;
    data['display_name'] = this.displayName;
    data['link'] = this.link;
    return data;
  }
}