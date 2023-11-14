import 'package:appgain/core/base/base_states.dart';
import 'package:appgain/core/extensions/num_extensions.dart';
import 'package:appgain/core/routing/navigation_services.dart';
import 'package:appgain/core/routing/routes.dart';
import 'package:appgain/core/services/network/network_info.dart';
import 'package:appgain/core/utils/logger.dart';
import 'package:appgain/data_layer/models/qustion_asnwer_model.dart';
import 'package:appgain/presentation_layer/logic/questions_cubit.dart';
import 'package:appgain/widgets/custom_assets_image.dart';
import 'package:appgain/widgets/custom_button.dart';
import 'package:appgain/widgets/custom_text.dart';
import 'package:appgain/widgets/cutom_shimmer_image.dart';
import 'package:appgain/widgets/indicator.dart';
import 'package:appgain/widgets/spaces.dart';
import 'package:appgain/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain_layer/Entities/qustion_answer.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({super.key});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final ScrollController _controller = ScrollController();
  List<QuestionAnswer> questions = [];
  InternetConnectionChecker connectionChecker = InternetConnectionChecker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      NetworkInfoImpl networkInfoImpl = NetworkInfoImpl(connectionChecker);

      final result =
          await BlocProvider.of<QuestionsCubit>(context).getAllQuestion();
      questions.addAll(result);
      if(await networkInfoImpl.isConnected){
        _controller.addListener(() async {
          if (_controller.position.maxScrollExtent == _controller.offset) {
            final result
            = await BlocProvider.of<QuestionsCubit>(context).getAllQuestion(isPagination: true);
            for (var object in result) {
              questions.add(object);
            }
          }

        }) ;
      }
    });
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade700,
        child: Column(
          children: List.generate(4, (index) => Container(
            padding: EdgeInsets.all(10.h),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                border:
                Border.all(color: Colors.deepOrangeAccent, width: 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOwnerDataAndScore(
                    name: "loading",
                    score: 0 ,
                    ownerImage: "loading"
                ),
                const Divider(),
                _buildDatesAndViews(),
                VerticalSpace(10.h),
                CustomText(
                  "loading",
                  size: 20.h,
                  color: Colors.black87,
                  bold: true,
                ).header().start(),
                VerticalSpace(10.h),
                _buildTags([]),
                const Divider(),

              ],
            ),
          )),
        ));
  }

  Widget _buildDatesAndViews() {
    return SizedBox(
      width: 320.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          const CustomText(
            "Asked: ",
            color: Colors.black87,
          ).start(),
          const CustomText(
            "Views: ",
            color: Colors.black87,
          ).start(),
        ],
      ),
    );
  }

  Widget _buildOwnerDataAndScore(
      {required String name, required int score, required String ownerImage}) {
    return SizedBox(
      width: 320.w,
      child: Row(
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

        ],
      ),
    );
  }

  Widget _buildButtons({required int index}) {
    return SizedBox(
      width: 320.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomButton(
            width: 200.w,
            onTap: (){
              NavigationService.push(Routes.questionDetails , arguments: {"question": questions[index]});
            },
            backgroundColor: Colors.deepOrangeAccent,
            textColor: Colors.white,
            buttonText: "More Details",
          ),

        ],
      ),
    );
  }

  Widget _buildTags(List<dynamic> tags) {
    if (tags.length > 3) {
      return SizedBox(
        height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              width: 280.w,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                      margin: EdgeInsets.only(right: 5.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                      ));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(
                child: CustomText(
                  "+${tags.length - 3}",
                  size: 10.h,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 40.h,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.only(right: 5.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(
                child: CustomText(
                  "${tags[index]}",
                  size: 10.h,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildQuestionList() {
    return AnimationLimiter(
      child: Column(
        children: [
          Expanded(child:  ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: questions.length,
            controller: _controller,

            itemBuilder: (BuildContext context, int index) {
              return  AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 2000),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: Container(
                      padding: EdgeInsets.all(10.h),
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          border:
                          Border.all(color: Colors.deepOrangeAccent, width: 2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOwnerDataAndScore(
                              name: questions[index].owner.displayName!,
                              score: questions[index].score ,
                              ownerImage: questions[index].owner.profileImage.toString()
                          ),
                          const Divider(),


                          CustomText(
                            questions[index].title,
                            size: 20.h,
                            color: Colors.black87,
                            bold: true,
                          ).header().start(),

                          const Divider(),
                          _buildButtons(index: index)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },

          ) ,) ,
          BlocBuilder<QuestionsCubit, QuestionsState>(
            builder: (context, state) {

              if (state.paginationState == BaseState.loaded) {
                return Container();
              } else if (state.paginationState == BaseState.loading) {
                return const MyProgressIndicator(color: Colors.deepOrangeAccent,);
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAssetsImage(
          image: "assets/pngwing.com.png",
          height: 70,
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<QuestionsCubit, QuestionsState>(
          builder: (context, state) {
            log('State', '${state.state}');
            if (state.state == BaseState.loaded) {
              return _buildQuestionList();
            } else if (state.state == BaseState.loading) {
              return _buildShimmerLoader();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
