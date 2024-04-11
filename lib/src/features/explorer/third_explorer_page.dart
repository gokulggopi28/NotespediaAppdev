// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'dart:convert';
//
// import '../../../utils/constants/app_export.dart'; // Ensure this import is correctly set up for your project structure
//
// class ThirdExplorerPage extends StatelessWidget {
//   ThirdExplorerPage({Key? key}) : super(key: key);
//
//   final GlobalKey<ScaffoldState> _explorerScaffoldKey =
//       GlobalKey<ScaffoldState>();
//   final ScrollController _explorerScreenScrollController = ScrollController();
//
//   Future<List<dynamic>> fetchPosts() async {
//     final url = Uri.parse(
//         'https://notespaedia.deienami.com/api/explore/explore_posts/');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       return data['data'];
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(CartAndOrderController());
//     Get.put(CircularStoryController());
//     return Scaffold(
//       key: _explorerScaffoldKey,
//       drawer:
//           MainNavigationDrawer(), // Ensure this is a previously defined widget or replace with your widget
//       body: CustomScrollView(
//         controller: _explorerScreenScrollController,
//         slivers: <Widget>[
//           MainBasicSliverAppbar(
//             text: "Explorer",
//             onPressed: () {
//               _explorerScaffoldKey.currentState?.openDrawer();
//             },
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(8),
//             sliver: FutureBuilder<List<dynamic>>(
//               future: fetchPosts(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return SliverFillRemaining(
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (snapshot.hasError) {
//                   return SliverFillRemaining(
//                     child: Center(child: Text("Error: ${snapshot.error}")),
//                   );
//                 }
//
//                 final posts = snapshot.data!;
//                 return SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       int actualIndex = (index ~/ 3) * 3 + index % 3;
//                       if (index % 3 == 0 && actualIndex < posts.length) {
//                         return _PostItem(
//                             post: posts[actualIndex], isLarge: true);
//                       } else if (index % 3 == 1 && actualIndex < posts.length) {
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     right:
//                                         4), // Add right padding to the first item
//                                 child: _PostItem(
//                                     post: posts[actualIndex], isLarge: false),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left:
//                                         4), // Add left padding to the second item
//                                 child: actualIndex + 1 < posts.length
//                                     ? _PostItem(
//                                         post: posts[actualIndex + 1],
//                                         isLarge: false)
//                                     : Container(),
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                       return Container(); // For indices that don't correspond to a post
//                     },
//                     childCount: ((posts.length + 2) ~/ 3) *
//                         3, // Adjusted count to ensure it's a multiple of 3
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _PostItem extends StatelessWidget {
//   final Map<String, dynamic> post;
//   final bool isLarge;
//
//   const _PostItem({
//     Key? key,
//     required this.post,
//     this.isLarge = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double containerHeight = isLarge ? 400.0 : 200.0;
//     final String formattedDate = post['created_on'] != null
//         ? DateFormat('MMMM yyyy').format(DateTime.parse(post['created_on']))
//         : 'Unknown Date';
//     final String postTitle = post['post_title'] ?? 'Untitled';
//     final String fileUrl =
//         post['file_url'] ?? 'https://example.com/default_image.png';
//     final String name = post['name'] ?? 'Anonymous';
//     final String profileImage =
//         post['profile_image'] ?? 'https://example.com/default_profile.png';
//
//     return Container(
//       height: containerHeight,
//       margin: EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Image.network(
//                 fileUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.4),
//               ),
//             ),
//             Positioned(
//               left: 8,
//               bottom: 8,
//               right: 8,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     postTitle,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(profileImage),
//                         radius: 17,
//                       ),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           name,
//                           style: TextStyle(color: Colors.white, fontSize: 14),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         "Follow",
//                         style: TextStyle(
//                           color: Color(0xFF05CF64),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(
//                           width: 8), // Space between "Follow" text and date
//                       Text(
//                         formattedDate,
//                         style: TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 8,
//               bottom: 8,
//               child: Icon(Icons.more_vert, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notespedia/models/user_profile.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import '../../../models/user_profile.dart';
import '../../../repositories/user_preferences.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../../widgets/profile/user_profile_repo.dart';
import '../../widgets/reusable/greenContainer.dart';

class ThirdExplorerPage extends StatefulWidget {
  const ThirdExplorerPage({super.key});

  @override
  State<ThirdExplorerPage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ThirdExplorerPage> {
  final UserProfileController subscriptionController =
      Get.put(UserProfileController());
  final UserProfileRepository userProfile = Get.put(UserProfileRepository());
  var userid = UserPreferences.userId;

  @override
  void initState() {
    super.initState();
    subscriptionController.checkSubscription(
        subscriptionController.userProfile.value?.getMeNotified ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    String masterYourNotes = "Master Your Notes \n& Share Your \nKnowledge";
    String getNotified = "Get Notified";
    String youCanKnowWho =
        "You can know who is interested in your knowledgeable notes by sharing them on the Explore page, increasing your engagement";
    String effortlesslyOrganize =
        "Effortlessly organize and improve your notes then seamlessly share your knowledge to inspire and collaborate with others";
    String notesPedia = "Notespedia's 'Explore':\nShare & Revise Notes Easily!";
    // String startUsingNotesPaedia ="Start using Notespaedia’s‘\nExplore’ first ";
    // String getAhead ="Get Ahead: Be the First to Explore Notespaedia’s\nNewest Feature";
    // String learnFrom ="Learn from others' study strategies and note-taking techniques";
    // String encourageDiscussions ="Encourage discussions and knowledge sharing in the Notespedia community.";
    // String arrow ="assets/images/svg/Arrow 10.svg";
    // String beTheFirst ="Be the first";
    // String emailAddress ="Email address";

    final List<Map<String, dynamic>> images = [
      {
        'image':
            'https://s3-alpha-sig.figma.com/img/a835/ee64/42e76927909c70831a99afc7e68db6c6?Expires=1713139200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NQU4vrgv4WYAVpTdmZ5K8YtbN9DdjAonBjrfNX1EM0Of2cf-s3SZqFu0YWvWUiPGnNI~wH-Yirzfk91CXiLmmzpWE7arCot5oWxhU9gxN0HKYv9n5O0V1Hsk45mX~~81jvRYqvyTSC9vLV0eco5Ju7Kd5T4Rl9qA9XWlMz0cWre3NliJvunNbg8mR92gRKouLBvtB7kMW7UUWwI1Nw1AlxYhBcqC00V5VvndEmkhFpPX2TKMIzJR1UI1gC6Mmoz24N7UCyJgyWx~2mvUfc8CFnl85N8xM2asPVRZzsv4ySJ~hC2WyUKzqPmBJgP9fSMDsLjwncLGKBQ217JZyaOMQQ__',
        "title": "Upload photos or PDF",
        'description':
            'Share your notes with others by uploading photos or PDFs.',
      },
      {
        'image':
            'https://s3-alpha-sig.figma.com/img/22d4/9a8b/522a83144d8f848a38ac101293e9b40e?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kvbnyY-T4TKM1GLlyo7Wj4r-J~cuhKP-55tNOfRNZ1kFDeDW9ZlAmEOe1yfxHqwkCxjI-N9yahKWZAASsnO7yIh7r3wMhn9va4jG8uGhnI6V0MoH1pe2umUrXZX9WDqZlT8lpk7M2W3m4pQHjVgaavHlutUVcLchE6-se8mAdIPS6iqfGHDRb6-uAq3ckRAEvK8mHLAZIMrXE4PcttEs2XgqXV3gjhUgF3IAEiAkC34hOq5rhjMmbYVk0069tLZa9oJ7h9srpy7DwQH~eLmarCAhv8bNj-qkFja0H5lhCEyj6TZof1z-3S2kcCLSc9sMd5pcb1ejew4T0QPCzsJJQQ__',
        "title": "Personalized study feed",
        'description':
            'Enhance learning through shared methods, insights, and diverse perspectives.',
      },
      {
        'image':
            'https://s3-alpha-sig.figma.com/img/dcc9/fbfa/b1939afcd445619319af89d2f7952676?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=WcuWYqez~29rRqtfECe4cwrD5DGpGXNzvjTt7iYJf6wWtVGM8BMsSvzWSg4mcoXuqfwnQ51M4GRYanzZQLEcnqJ3TNQZjmJWXvaLeHyuadigrrOus~BvzyyzgqoFe1r~nd1ncWIZnA0CP-6jmok8~8ImIdLrAD8vrHn9upnCrxYzR9Kv6GMg2vS2B0taPB1TmlYNWfsWsRhXiR3~imIAY-TLwAyke85Bbo~EsO1FN0jABORK96jBo7MDhBPpktKTiOiKv~M9rhJhgDIOBG5GdBvB2Wj~XUfpZAwrgaQBujRez3vvx3sulhzyUAZm91O-JOFNVs3CZEIA4DyEzjNUsw__',
        "title": "Boost your understanding",
        'description': 'Unlock Deeper Insights with Expert Guidance',
      },
      {
        'image':
            'https://s3-alpha-sig.figma.com/img/d05b/57ca/9e2ed9688c7f4e0695f0d0bc9f36e3ed?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Tu3kVUh7IXHRPf5YaUgKU77RESosYThdVx33Isq4fZXBNZXfXeUvIvej5Y2k8ycuLiiPEoJxYEn8imDTBtqWFCaAo0CDr-u2mgU88aiHe1vn-S-M2u5EdvrMGu1SFxdAC9aWWQ9iM71icvOU15wkAd7kpN1~IoZ~s1NiePQuS93AXzu9KDGCS-69sKLnfGU0KwaCYuQvsCqWm7Elm5FxJNkdYWN9hUQ2pTuDUeZaWzxraa~G5UrvV2vbTgHkPz4nFyIikIT8O6AlIXITawFV8O7I-ncjr-FFEI1-hWbvv3C~xXtgKBulcAAjgVxsqdWHbxr0OCM2osNFCU-RKifAeg__',
        "title": "Achieve you goal",
        'description':
            'Transform your aspirations into achievements with our supportive platform',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => CustomScrollView(
            slivers: [
              MainBasicSliverAppbar(
                text: "Explorer",
                onPressed: () {
                  // _explorerScaffoldKey.currentState?.openDrawer();
                },
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      greenContainer(
                          context,
                          masterYourNotes,
                          effortlesslyOrganize,
                          subscriptionController.subscriptionStatus.value, () {
                        HelperFunctions.showTopSnackBar(
                          context: context,
                          title: "Status Message",
                          message:
                              "Thank you for subscribing! You'll be notified as soon as there are updates",
                        );
                        subscriptionController.checkSubscription(1);
                        userProfile.getNotifiedApi(
                            userid, subscriptionController.number.value);
                      }),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            notesPedia,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        youCanKnowWho,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          color: Colors.black.withOpacity(.64),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 56,
                      ),
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
                      mainAxisExtent: 280.sp),
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
                                  image: Image.network(images[index]["image"])
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(images[index]["title"],
                                      style: TextStyle(
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
                                  child: Text(images[index]["description"],
                                      style: TextStyle(
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
      ),
    );
  }
}
