import 'package:notespedia/utils/constants/app_export.dart';

class ExpandableFilterItem extends StatefulWidget {
  final String title;
  final List<Widget> Function()? contentBuilder;

  ExpandableFilterItem({Key? key, required this.title, this.contentBuilder})
      : super(key: key);

  @override
  _ExpandableFilterItemState createState() => _ExpandableFilterItemState();
}

class _ExpandableFilterItemState extends State<ExpandableFilterItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(widget.title),
          trailing: IconButton(
            icon: Icon(_isExpanded ? Icons.remove : Icons.add),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ),
        if (_isExpanded && widget.contentBuilder != null)
          ...widget.contentBuilder!(),
      ],
    );
  }
}
