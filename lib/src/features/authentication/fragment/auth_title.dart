import 'package:notespedia/utils/constants/app_export.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF4B4B4B),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
      ),
    );
  }
}
