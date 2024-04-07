import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusablePasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? contentPadding;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final int? maxLines;
  final int? maxLength;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final bool? autofocus;
  final MouseCursor? mouseCursor;
  final bool? obscureText;

  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? errorFocusedBorderColor;

  final bool? filled;
  final Color? fillColor;

  final Widget? counter;
  final TextStyle? counterStyle;
  final List<String>? autofillHints;

  final Color? textColor;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final TextAlign? textAlign;
  final double? fontSize;

  final bool? enableInteractiveSelection;
  final Color? cursorColor;
  final Color? labelColor;
  final bool? decorationEnable;
  final InputDecoration? decoration;

  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;

  final IconData? prefixIconData;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final double? prefixIconSize;
  final bool? prefixIconEnable;
  final bool? suffixIconEnable;

  const ReusablePasswordFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.width,
    this.height,
    this.constraints,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.keyboardAppearance,
    this.maxLines,
    this.maxLength,
    this.errorMaxLines,
    this.hintMaxLines,
    this.enableSuggestions,
    this.autocorrect,
    this.autofocus,
    this.mouseCursor,
    this.obscureText,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.errorFocusedBorderColor,
    this.filled,
    this.fillColor,
    this.counter,
    this.counterStyle,
    this.autofillHints,
    this.style,
    this.labelStyle,
    this.floatingLabelStyle,
    this.textAlign,
    this.fontSize,
    this.enableInteractiveSelection,
    this.cursorColor,
    this.labelColor,
    this.decorationEnable = true,
    this.decoration,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.prefixIconData,
    this.prefixIconColor,
    this.prefixIconSize,
    this.prefixIconEnable,
    this.suffixIconEnable,
    this.textColor,
    this.suffixIconColor,
  });

  @override
  State<ReusablePasswordFormField> createState() =>
      _ReusablePasswordFormFieldState();
}

class _ReusablePasswordFormFieldState extends State<ReusablePasswordFormField> {
  //
  bool _obscureText = true;

  void passwordVisibilityToggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    final bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        autofocus: widget.autofocus ?? false,
        autofillHints: widget.autofillHints ??
            [
              AutofillHints.password,
              AutofillHints.newPassword,
            ],
        obscureText: widget.obscureText ?? _obscureText,
        style: widget.style ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.textColor ??
                      (darkMode
                          ? const Color(0xFFD5EBF6)
                          : const Color(0xFF101213)),
                  fontSize: widget.fontSize ?? 16,
                  fontWeight: FontWeight.w500,
                ),
        decoration: widget.decorationEnable == true
            ? (InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                labelStyle: widget.labelStyle ??
                    Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: widget.labelColor ?? const Color(0xFF57636C),
                          fontSize: widget.fontSize ?? 16,
                          fontWeight: FontWeight.w500,
                        ),
                floatingLabelStyle: widget.floatingLabelStyle ??
                    Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF57636C),
                          fontSize: widget.fontSize ?? 16,
                          fontWeight: FontWeight.w500,
                        ),
                filled: widget.filled ?? true,
                fillColor: widget.fillColor ??
                    (darkMode
                        ? Colors.white.withOpacity(.1)
                        : const Color(0xFFF1F4F8)),
                constraints: widget.constraints,
                contentPadding: widget.contentPadding,
                counter: widget.counter ?? const Offstage(),
                counterStyle: widget.counterStyle,
                errorMaxLines: widget.errorMaxLines ?? 1,
                hintMaxLines: widget.hintMaxLines ?? 1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor ??
                        (darkMode
                            ? const Color(0xFF2F3031)
                            : const Color(0xFFF1F4F8)),
                    width: widget.borderWidth ?? 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor ??
                        (darkMode
                            ? const Color(0xFFA39BE8)
                            : const Color(0xFFA39BE8)),
                    width: widget.borderWidth ?? 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.errorBorderColor ??
                        (darkMode
                            ? const Color(0xFFE0E3E7)
                            : const Color(0xFFE0E3E7)),
                    width: widget.borderWidth ?? 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.errorFocusedBorderColor ??
                        (darkMode
                            ? const Color(0xFFE0E3E7)
                            : const Color(0xFFE0E3E7)),
                    width: widget.borderWidth ?? 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 12),
                ),
                prefixIcon: widget.prefixIconEnable == true
                    ? widget.prefixIcon ??
                        Icon(
                          widget.prefixIconData ?? Icons.key,
                          color: widget.prefixIconColor ??
                              (darkMode
                                  ? Colors.white.withOpacity(.8)
                                  : Colors.black.withOpacity(.8)),
                          size: widget.prefixIconSize,
                        )
                    : null,
                suffixIcon: widget.suffixIconEnable == true
                    ? widget.suffixIcon ??
                        (IconButton(
                          icon: Icon(
                            _obscureText
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: widget.suffixIconColor ??
                                (darkMode
                                    ? Colors.white.withOpacity(.5)
                                    : Colors.black.withOpacity(.5)),
                          ),
                          onPressed: () {
                            passwordVisibilityToggle();
                          },
                        ))
                    : null,
              ))
            : null,
        enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
        keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
        keyboardAppearance: widget.keyboardAppearance ?? Brightness.dark,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign ?? TextAlign.start,
        enableSuggestions: widget.enableSuggestions ?? true,
        autocorrect: widget.autocorrect ?? false,
        mouseCursor: widget.mouseCursor ?? SystemMouseCursors.text,
        cursorColor: widget.cursorColor ??
            (darkMode ? const Color(0xFFA39BE8) : const Color(0xFFA39BE8)),
        validator: widget.validator,
        // This callback function is called when
        // the user presses the keyboard's "Done" or
        // "Next" button (depending on the platform).
        // It's useful for performing actions when the
        // user finishes editing a field but before the
        // form is submitted.
        onEditingComplete: widget.onEditingComplete,
        // This callback function is called whenever
        // the text input value changes. It allows
        // you to react to changes in real-time as
        // the user types. It's often used for live
        // feedback or updating the UI based on user input.
        onChanged: widget.onChanged,
      ),
    );
  }
}
