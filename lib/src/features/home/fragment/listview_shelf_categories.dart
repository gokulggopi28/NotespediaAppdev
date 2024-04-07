import 'package:flutter/material.dart';
// Adjust this import as necessary
import '../../../../models/shelf_category.dart';
import '../../../../repositories/user_preferences.dart';
import '../../../../utils/constants/app_export.dart';
import '../../detailed/grid_view_book_list.dart';
import '../controller/downloadandopenpdf.dart';
import '../controller/shelf_category_controller.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart'; // Adjust this import as necessary
// Adjust this import as necessary to where your BookCard widget is defined

class FutureBuilderSliverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ShelfBook>>(
      future: fetchShelfBooks(), // Ensure this fetches your categories
      builder: (BuildContext context, AsyncSnapshot<List<ShelfBook>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return SliverToBoxAdapter(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Container(
              height: 300, // Adjust container height if needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final ShelfBook book = snapshot.data![index];
                  return Container(
                    width: 170, // Adjust based on your content
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:
                              200, // Specify the height for the BookCard here
                          child: BookCard(
                            imageUrl: book.coverImage,
                            onTap: () async {
                              int bookId = book.bookId;
                              int userId = book.userId;
                              Get.to(() => ResponsiveGrid(
                                  bookId: bookId, userId: userId));
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          book.name, // Displaying the book's name
                          style: TextStyle(fontWeight: FontWeight.bold),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Additional UI elements can be added below as needed
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return SliverToBoxAdapter(child: Text('No data found'));
      },
    );
  }
}
