import 'package:notespedia/utils/constants/app_export.dart';

class OrSection extends StatelessWidget {
  const OrSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Flexible(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('or',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    )),
          ),
          const Flexible(child: Divider()),
        ],
      ),
    );
  }
}
