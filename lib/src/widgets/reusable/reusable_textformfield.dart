import '../../../utils/constants/app_export.dart';

class ReusableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autofocus;
  final bool enableSuggestions;
  final bool autocorrect;
  final List<String>? autofillHints;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const ReusableTextFormField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.autofillHints,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.onTap,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      enableSuggestions: true,
      autocorrect: false,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      onTap: onTap,
      spellCheckConfiguration: SpellCheckConfiguration(
        misspelledTextStyle:
            Theme.of(context).textTheme.labelMedium?.copyWith(),
        spellCheckService: DefaultSpellCheckService(),
      ),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(),
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        isCollapsed: true,
        enabled: true,
        alignLabelWithHint: true,
        errorMaxLines: 1,
        helperMaxLines: 1,
        hintMaxLines: 1,
        counter: const Offstage(),
        contentPadding: contentPadding ??
            const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 15.0,
              bottom: 15.0,
            ),
        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(),
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(),
        floatingLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(),
        errorStyle: Theme.of(context).textTheme.labelMedium?.copyWith(),
        counterStyle: Theme.of(context).textTheme.labelMedium?.copyWith(),
        helperStyle: Theme.of(context).textTheme.labelMedium?.copyWith(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.green,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
