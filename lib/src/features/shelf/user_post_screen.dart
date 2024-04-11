// import 'package:flutter/material.dart';
// import 'package:notespedia/models/local/local_user_posts.dart';
// import 'package:notespedia/src/features/home/controller/user_posts_controller.dart';
// import '../../../models/local/local_save_for_later_model.dart';
// import '../../../utils/constants/app_export.dart';
// import 'package:get/get.dart';
// import '../home/controller/save_later_controller.dart'; // Correct the path as needed
//
// class UserPostScreen extends StatelessWidget {
//   UserPostScreen({Key? key}) : super(key: key);
//
//   final UserPostController userPostController = Get.find<UserPostController>();
//   final nSController = Get.find<NetworkStateController>();
//   @override
//   Widget build(BuildContext context) {
//     userPostController.fetchUserPosts();
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: CustomScrollView(
//         scrollDirection: Axis.vertical,
//         physics: const ClampingScrollPhysics(),
//         slivers: [
//           //  const ReusableBackSliverAppbar(titleText: "Saved For Later"),
//           const SliverGap(18),
//           Obx(() {
//             if (userPostController.isProcessing.isTrue) {
//               return const SliverFillRemaining(
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             } else if (userPostController.hasError.isTrue) {
//               return SliverFillRemaining(
//                 child: Center(child: Text('Error loading posts')),
//               );
//             } else if (userPostController.userpostsList.isEmpty) {
//               return SliverFillRemaining(
//                 child: Center(child: Text('No Posts')),
//               );
//             } else {
//               return buildBooksGrid(context, userPostController.userpostsList);
//             }
//           }),
//           const SliverGap(42),
//         ],
//       ),
//     );
//   }
//
//   Widget buildBooksGrid(BuildContext context, List<Post> books) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double itemWidth = (screenWidth - (16 * 2) - (22 * (2 - 1))) / 2;
//
//     return SliverPadding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       sliver: SliverGrid(
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           mainAxisExtent: 330,
//           maxCrossAxisExtent: itemWidth,
//           crossAxisSpacing: 22,
//           mainAxisSpacing: 22,
//         ),
//         delegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             final book = books[index];
//             final Map<int, Widget> statusIndicator = {
//               1: const ReusableCompleteStatusIndicator(),
//               2: const ReusableOngoingStatusIndicator(),
//               3: const ReusableUpdateStatusIndicator(),
//             };
//
//             return SizedBox(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: BookCard(
//                       imageUrl: book.coverImage,
//                       onTap: () async {
//                         // final currentBookId = book.bookId;
//
//                         // if (nSController.isInternetConnected.isTrue) {
//                         //   await saveForLaterBooksController
//                         //       .fetchBookDetails(currentBookId);
//
//                         //   var bookDetail = saveForLaterBooksController
//                         //       .saveforlaterbookDetailList
//                         //       .firstWhereOrNull(
//                         //           (detail) => detail.bookId == currentBookId);
//
//                         //   if (bookDetail != null) {
//                         //     // If book detail is found
//                         //     Get.to(() =>
//                         //         BooksDetailsScreen(bookDetailData: bookDetail));
//                         //   } else {
//                         //     print(
//                         //         "Book detail not found for book ID: $currentBookId");
//                         //   }
//                         // } else {
//                         //   // Handle no internet connection case
//                         //   print("No internet connection.");
//                         // }
//                       },
//                     ),
//                   ),
//                   const Gap(6),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: BookTitle14(
//                           title: book.title,
//                         ),
//                       ),
//                       const Gap(6),
//                       ReusableMoreOptionButton(
//                         onPressed: () {
//                           // Implement your logic for more options here
//                         },
//                       ),
//                     ],
//                   ),
//                   // Row(
//                   //   children: [
//                   //     statusIndicator[book.stage] ??
//                   //         const ReusableUpdateStatusIndicator(),
//                   //     const Gap(6),
//                   //     Expanded(
//                   //       child: BookIndicatorText10Widget(
//                   //         text: book.authorName,
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             );
//           },
//           childCount: books.length,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../../repositories/user_preferences.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../../widgets/profile/user_profile_repo.dart';
import '../../widgets/reusable/greenContainer.dart';
class ProfilePostScreen extends StatefulWidget {
  const ProfilePostScreen({super.key});

  @override
  State<ProfilePostScreen> createState() => _ProfilePostScreenState();
}

class _ProfilePostScreenState extends State<ProfilePostScreen> {
  final UserProfileController subscriptionController = Get.put(UserProfileController());
  final UserProfileRepository  userProfile= Get.put(UserProfileRepository());

  @override
  void initState() {
    super.initState();
    subscriptionController.checkSubscription(subscriptionController.userProfile.value?.getMeNotified??0);
  }
  @override
  Widget build(BuildContext context) {
    String readingStatus ="Reading status, \nShare & Connect to \nCo-Learners";
    String getNotified ="Get Notified";
    String stayOnTop ="Stay on top of your reading progress and easily recall what you've shared with this convenient feature";
    String effortlesslyTrack = "Effortlessly track your reading progress \nand engage with fellow learners to enhance \ncollaboration and learning experiences";
    String neverLoseTrack ="Never lose track of your reading progress or forget what you've shared.";

    final List<Map<String, dynamic>> images = [
      {
        'image': 'https://s3-alpha-sig.figma.com/img/2135/bf50/99673310a56a274f00f792e3a12ba445?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=SwhxZz3rw0vkU-bRJT8udME63z2jLgtmS630b83H3RAnXB-v4mI6~rFsH2uuk2~Cn8~6sBV2-Z8kG4yyVxbJIpQeSWyjHyLxd2w6TtWZB8B21fcDwIEBfKmq9GukBW2Tm4i~dQj-zD-YR1PtUdBi5XNpmoZKkIEaQSSOhw0FulOp90~aGUpOema8ft873X8cK08fQuxgV1jpvqXvsNAPTowlk7Dt3Kx1-lo31JFtrIU8E7cllq8zOlS4msNKPdFwXl0btEpIjEK9xJNJxEdKfRw8XeZkZpsVLTzNDuq3ZFQy8DIGtQnTK3tlicVzRZrT9lNkUfifyJHTD3D8qGPOYg__',
        "title":"Track your reading progress ",
        'description': 'Monitor your reading journey with ease and stay motivated as you progress through books ',
      },
      {
        'image': 'https://s3-alpha-sig.figma.com/img/aca8/d432/b28e9f940752a9bbd8127064bd8217c7?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bDvwdnaIM8VQzVPX9eHEfYYB0NEnvWS82L~8bMYOefbt0el4~fiqwvyE17GB8g3zcvRiTV9q9aHuuNO3OUMhcUjehAniJa-q6lyoRKvMkHg10oNbJ3hZ7Pxrj7yKdfqp3hj88A3chROM1qMs0VqSZZvEqFrnskV7b9yhzNBKqYk4N7t~3CcMPTijljaA2sp09uRHCLwVtE1xqg2BZt1kJU8KbVcJT0LYYmff1R6KjONByfNOaH2nucWAnt53TExMug1Lz0wHcVxmFNmL3HFzpoBL8YzuhjEsYZey5H51mU9M4K7zpj0uCk1-zaTLJ-ozPoNbqnkVv3sDLvaBpQWE6g__',
        "title":"Public post",
        'description': 'Elevate your learning by sharing study methods and insights, while gaining valuable perspectives and ideas from others',
      },
      {
        'image': 'https://s3-alpha-sig.figma.com/img/ae97/b5a7/9af84a95054e18edf0245561c605efe1?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XjBmJtMh34txT4wmrlVeE58BDJj1~qVlpWK2IoDtuNYCQ278-b-15s-6KcMuLhxnxJI0IMsgWYnNrejaHSmg3UWUG3lWVH-dbX-RyoePs~Pawcv0uqfkaub5lvRo8k2JHHbfvL8sltN7-ERmg5QAhZ3LC8p1W2ah-IipXXvhaAXIeyc~BHEhyHRurVNFNH0VNM5gLGn5RWhiu35HZhUDShidJIlSBunsvtQx-7Is4NTWjVARSSYzt6Gw6B0mgd7ptxkDSuQg~-RpCsiRWIWceKFLbx5VlW6s1GN-bPtjtS1FYoL63o2vGxnCPHgDwNtYkSOMxuewOMS8ZLky5PlALg__',
        "title":"Share Your written Notes",
        'description': 'Collaborate and learn together by sharing your valuable notes with others.',
      },
      {
        'image': 'https://s3-alpha-sig.figma.com/img/2db9/8166/54a86ba82e435aa1cae8ad6ec0520f01?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Y2GPhe5FIbxxTWfpV-ViOMhcM8LtNT7IfknXIqKcajbB-hog1yiJE3Ur~mPMF1LRn7vwtUFJ~HfMZvxjjX7USCzck7ZxJqCLMbiBzeZ348HNa4lCNbOjLWOhtU5i3jc2-4IkiKMABulm7YolEKKHhMBwN6jXaaCNOrpRuIH9ItEnicsFhkQ4c7VY~pVDh-VhMUho2bdSuI6YzDNrNIwm13SiJpwshul71E0P~3WAK75XkvbikwTs5ikX15WGESaqoJgVhdT8wP1Dx~0P9XjoWk1vyRJbqvJU0H22KeQZq7cEW1esVlFOezezsC9cq5l26idlPVVdeKqs7btjchlAuQ__',
        "title":"Collaborate",
        'description': 'Connect, share, learn, support.',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                   Obx(() => greenContainer(context, readingStatus, effortlesslyTrack,subscriptionController.subscriptionStatus.value,
                              () {
                                HelperFunctions.showTopSnackBar(
                                  context: context,
                                  title: "Status Message",
                                  message: "Thank you for subscribing! You'll be notified as soon as there are updates",
                                );
                                var userid = UserPreferences.userId;
                                subscriptionController.checkSubscription(1);
                                userProfile.getNotifiedApi(userid,subscriptionController.number.value);
                          }),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            neverLoseTrack,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(stayOnTop,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        color: Colors.black.withOpacity(.64),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 56,),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 30,
                    mainAxisExtent:300.sp),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Action on image tap
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 147,
                            width: 156,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.network(images[index]["image"]).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(images[index]["title"], style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(images[index]["description"], style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Colors.black.withOpacity(.64),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                              ),
                            ],
                          ),
                          // SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                  childCount: images.length,
                ),
              ),
            ),
            // SliverPadding(
            //   padding: EdgeInsets.all(12),
            //   sliver: SliverToBoxAdapter(
            //     child: Column(
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(color: Color.fromRGBO(234, 244, 241, 1)),
            //           child: Padding(
            //             padding: const EdgeInsets.all(24),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       startUsingNotesPaedia,
            //                       style: TextStyle(
            //                           fontSize: 24.sp,
            //                           fontWeight: FontWeight.w600,
            //                           color: Color.fromRGBO(5, 207, 100, 1)),
            //                     ),
            //                     SizedBox(height: 8,),
            //                     Text(
            //                       getAhead,
            //                       style: TextStyle(
            //                           fontSize: 14.sp,
            //                           fontWeight: FontWeight.w500,
            //                           color: Colors.black.withOpacity(.7)),
            //                     ),
            //                     SizedBox(height: 24,),
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         SvgPicture.asset(arrow),
            //                         Expanded(child: Padding(
            //                           padding: const EdgeInsets.only(left: 16),
            //                           child: Text(learnFrom),
            //                         ))
            //                       ],
            //                     ),
            //                     SizedBox(height: 32,),
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         SvgPicture.asset(arrow),
            //                         Expanded(child: Padding(
            //                           padding: const EdgeInsets.only(left: 16),
            //                           child: Text(encourageDiscussions),
            //                         ))
            //                       ],
            //                     ),
            //                     SizedBox(height: 46,),
            //                     Text(emailAddress,style: TextStyle(color: Color.fromRGBO(5, 207, 100, 1),fontWeight: FontWeight.w400,fontSize: 14),),
            //                     SizedBox(height: 8,),
            //                     Container(
            //                       height: 46,
            //                       color: Colors.white,
            //                       child: TextFormField(
            //                         decoration: InputDecoration(
            //                           errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
            //                             disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            //                             enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            //                             focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            //                             border: InputBorder.none,
            //                             contentPadding: EdgeInsets.all(8)
            //                         ),
            //                         cursorColor: Colors.black.withOpacity(.6),
            //                         // Other properties of TextFormField
            //                       ),
            //                     ),
            //                     SizedBox(height: 16,),
            //                     GestureDetector(
            //                       onTap: (){},
            //                       child: Container(
            //                         height: 46,
            //                         width: MediaQuery.of(context).size.width,
            //                         decoration: BoxDecoration(
            //                           color:  Color.fromRGBO(5, 207, 100, 1),),
            //                         child: Center(
            //                             child: Text(
            //                               beTheFirst,
            //                               style: TextStyle(
            //                                   fontSize: 14.sp,
            //                                   fontWeight: FontWeight.w600,
            //                                   color: Colors.white),
            //                             )),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         SizedBox(height: 56,),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );

  }
}



