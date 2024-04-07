import 'package:notespedia/utils/constants/app_export.dart';

class ReusableSliverListForTesting extends StatelessWidget {
  const ReusableSliverListForTesting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Color color = Colors.primaries[index % Colors.primaries.length];
          return Container(
            height: 100.0,
            color: color,
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        childCount: 20,
      ),
    );
  }
}
