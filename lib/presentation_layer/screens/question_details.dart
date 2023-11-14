import 'package:appgain/core/extensions/num_extensions.dart';
import 'package:appgain/core/utils/date/date_converter.dart';
import 'package:appgain/data_layer/models/qustion_asnwer_model.dart';
import 'package:appgain/widgets/custom_assets_image.dart';
import 'package:appgain/widgets/custom_text.dart';
import 'package:appgain/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';

import '../../domain_layer/Entities/qustion_answer.dart';
import '../../widgets/cutom_shimmer_image.dart';



class QuestionDetailsScreen extends StatelessWidget {
  final QuestionAnswer questionAnswer ;
  const QuestionDetailsScreen({super.key, required this.questionAnswer});
  Widget _buildDatesAndViews({required int answerCount , required int views}) {


    return SizedBox(
      width: 320.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
           CustomText(
            "answers: $answerCount",
            color: Colors.black87,
          ).start(),
           CustomText(
            "Views: $views",
            color: Colors.black87,
          ).start(),
        ],
      ),
    );
  }


  Widget _buildChioTags(List<dynamic> tags){
    List<String> newTags = [] ;
    tags.forEach((element) {newTags.add(element.toString());});
    return Wrap(children: List.generate(newTags.length, (index) => Container(
        margin: EdgeInsets.only(right: 5.w,bottom: 5.h),

        constraints: BoxConstraints(maxWidth: 120.w , ),
        padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10),
        decoration: BoxDecoration(
          color:
          Colors.primaries[index % Colors.primaries.length],
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: CustomText(
            "${tags[index]}",
            size: 10.h,
            color: Colors.white,
          ),
        ))),);
  }
  Widget _buildOwnerDataAndScore(
      {required String name, required int score, required String ownerImage}) {
    return SizedBox(
      width: 320.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(300.r),
                child: CustomShimmerImage(
                  image: ownerImage,
                  height: 40.h,
                  width: 40.h,
                ),
              ),
              CustomText(
                name,
                color: Colors.black,
                bold: true,
              )
            ],
          ),
          VerticalSpace(10.h) ,
          
          CustomText("Score: ${questionAnswer.score}")

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            CustomAssetsImage(image: "assets/pngwing.com.png" , height: 50.h,) ,

          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            VerticalSpace(10.h) ,
            Container(
              padding: EdgeInsets.all(10.h),
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOwnerDataAndScore(
                      name: questionAnswer.owner.displayName!,
                      score: questionAnswer.score ,
                      ownerImage: questionAnswer.owner.profileImage.toString()
                  ),
                  const Divider(),
                  _buildDatesAndViews(answerCount: questionAnswer.answerCount , views: questionAnswer.viewCount) ,
                  VerticalSpace(10.h) ,


                  CustomText(
                    questionAnswer.title,
                    size: 20.h,
                    color: Colors.black87,
                    bold: true,
                  ).header().start(),
                  VerticalSpace(10.h) ,


                  _buildChioTags(questionAnswer.tags),
                  CustomText("Answered: ${questionAnswer.isAnswered}" , bold: true,size: 12.h,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
