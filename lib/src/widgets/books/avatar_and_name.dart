import 'package:notespedia/utils/constants/app_export.dart';

class AvatarAndName extends StatelessWidget {
  const AvatarAndName({
    super.key,
    required this.authorProfilePic,
    required this.authorName,
  });

  final String authorProfilePic;
  final String authorName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 26,
          height: 26,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
          ),
          child: ReusableCachedNetworkImage(
            imageUrl: authorProfilePic,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(6),
        Flexible(
          child: Text(
            authorName ?? 'Dr.Rajamahendran',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}
