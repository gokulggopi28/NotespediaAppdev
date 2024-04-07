import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../../utils/constants/app_export.dart'; // Ensure this import is correctly set up for your project structure

class ThirdExplorerPage extends StatelessWidget {
  ThirdExplorerPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _explorerScaffoldKey =
      GlobalKey<ScaffoldState>();
  final ScrollController _explorerScreenScrollController = ScrollController();

  Future<List<dynamic>> fetchPosts() async {
    final url = Uri.parse(
        'https://notespaedia.deienami.com/api/explore/explore_posts/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CartAndOrderController());
    Get.put(CircularStoryController());
    return Scaffold(
      key: _explorerScaffoldKey,
      drawer:
          MainNavigationDrawer(), // Ensure this is a previously defined widget or replace with your widget
      body: CustomScrollView(
        controller: _explorerScreenScrollController,
        slivers: <Widget>[
          MainBasicSliverAppbar(
            text: "Explorer",
            onPressed: () {
              _explorerScaffoldKey.currentState?.openDrawer();
            },
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: FutureBuilder<List<dynamic>>(
              future: fetchPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(child: Text("Error: ${snapshot.error}")),
                  );
                }

                final posts = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      int actualIndex = (index ~/ 3) * 3 + index % 3;
                      if (index % 3 == 0 && actualIndex < posts.length) {
                        return _PostItem(
                            post: posts[actualIndex], isLarge: true);
                      } else if (index % 3 == 1 && actualIndex < posts.length) {
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        4), // Add right padding to the first item
                                child: _PostItem(
                                    post: posts[actualIndex], isLarge: false),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        4), // Add left padding to the second item
                                child: actualIndex + 1 < posts.length
                                    ? _PostItem(
                                        post: posts[actualIndex + 1],
                                        isLarge: false)
                                    : Container(),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container(); // For indices that don't correspond to a post
                    },
                    childCount: ((posts.length + 2) ~/ 3) *
                        3, // Adjusted count to ensure it's a multiple of 3
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final Map<String, dynamic> post;
  final bool isLarge;

  const _PostItem({
    Key? key,
    required this.post,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerHeight = isLarge ? 400.0 : 200.0;
    final String formattedDate = post['created_on'] != null
        ? DateFormat('MMMM yyyy').format(DateTime.parse(post['created_on']))
        : 'Unknown Date';
    final String postTitle = post['post_title'] ?? 'Untitled';
    final String fileUrl =
        post['file_url'] ?? 'https://example.com/default_image.png';
    final String name = post['name'] ?? 'Anonymous';
    final String profileImage =
        post['profile_image'] ?? 'https://example.com/default_profile.png';

    return Container(
      height: containerHeight,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                fileUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              right: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(profileImage),
                        radius: 17,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Follow",
                        style: TextStyle(
                          color: Color(0xFF05CF64),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                          width: 8), // Space between "Follow" text and date
                      Text(
                        formattedDate,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
