// import 'package:notespedia/utils/constants/app_export.dart';

// import '../../features/detailed/controller/expandable_list_controller.dart';
// import '../../features/home/controller/pdf_viewer.dart';

// class ChapterInfoSliverList extends StatelessWidget {
//   ChapterInfoSliverList({
//     super.key,
//   });
//   final controller = Get.put(ExpandableListController());
//   final bdController = Get.find<BooksDetailController>();
//   final authController = Get.find<AuthenticationController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (bdController.isProcessing.isTrue) {
//         return sliverListLoadingShimmer();
//       } else if (bdController.hasError.isTrue) {
//         return sliverListLoadingShimmer();
//       } else {
//         return SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               final bool isDisabled = index > 2 && !controller.isLoggedIn.value;

//               return Padding(
//                 padding: EdgeInsets.only(bottom: isDisabled ? 0 : 1.5),
//                 child: Material(
//                   color: isDisabled ? Colors.grey : Colors.white,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: isDisabled
//                               ? null
//                               : () async {
//                                   String pdfUrl =
//                                       bdController.bookDetailData[0].fileurl;
//                                   int startPage = bdController
//                                       .bookChaptersList[index].startPage;

//                                   if (pdfUrl.isNotEmpty) {
//                                     await downloadAndOpenPdf(context, pdfUrl,
//                                         startPage: startPage);
//                                   } else {
//                                     print(
//                                         "PDF URL is not available or invalid.");
//                                   }
//                                 },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Visibility(
//                                       visible: index > 0,
//                                       child:
//                                           const ReusableCompleteStatusIndicator(
//                                               radius: 5),
//                                     ),
//                                     Visibility(
//                                       visible: index > 0,
//                                       child: const Gap(4),
//                                     ),
//                                     Text(
//                                       "Chapter ${bdController.bookChaptersList[index].chapterIndex}",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleMedium
//                                           ?.copyWith(
//                                             color:
//                                                 Colors.black.withOpacity(0.5),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Gap(6),
//                                 Text(
//                                   bdController
//                                       .bookChaptersList[index].chapterName,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall
//                                       ?.copyWith(
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                 ),
//                                 const Gap(6),
//                                 Text(
//                                   "${bdController.bookChaptersList[index].readPages}/${bdController.bookChaptersList[index].pages} Pages",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium
//                                       ?.copyWith(
//                                         color: Colors.black,
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           // Your download logic here
//                         },
//                         icon: const Icon(
//                           Icons.download, // Modify as per your actual icon
//                           size: 24,
//                           color: Colors.grey, // Modify as per your actual color
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             childCount: authController.isLoggedIn.isTrue
//                 ? bdController.bookChaptersList.length
//                 : 3,
//           ),
//         );
//       }
//     });
//   }

//   Widget sliverListLoadingShimmer() {
//     return SliverList.separated(
//       separatorBuilder: (BuildContext context, int index) {
//         return const Gap(1.5);
//       },
//       itemBuilder: (BuildContext context, int index) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: const Column(
//                     children: [],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//               ),
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       itemCount: 5,
//     );
//   }
// }
