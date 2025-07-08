import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldUI extends StatefulWidget {
  final String? title;
  final int? titleMaxLines;
  final String? label;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool? required;
  final bool? enable;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? readOnly;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? hint;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;
  final Function(String value)? onChange;
  final TextInputType? inputType;
  final double? height;
  final double? width;
  final double? maxHeight;
  final double? maxWidth;
  final double? minHeight;
  final double? minWidth;
  final bool? wrapWidth;
  final CustomPainter? painter;
  final double? borderRadius;
  final bool? formatCurrency;
  final InputBorder? inputBorder;
  final Color? focusBorderColor;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final bool? canTapOutside;
  final Function(String value)? onFieldSubmitted;
  final Color? cursorColor;
  final TextInputAction? textInputAction;

  const TextFieldUI(
      {super.key,
      this.title,
      this.titleMaxLines,
      this.label,
      this.suffixIcon,
      this.icon,
      this.required,
      this.enable,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.readOnly,
      this.onTap,
      this.onChange,
      this.controller,
      this.isPassword,
      this.hint,
      this.inputType,
      this.borderColor,
      this.margin,
      this.height,
      this.width,
      this.maxHeight,
      this.maxWidth,
      this.minHeight,
      this.minWidth,
      this.wrapWidth,
      this.painter,
      this.borderRadius,
      this.formatCurrency,
      this.inputBorder,
      this.textAlign,
      this.focusNode,
      this.validator,
      this.hintStyle,
      this.backgroundColor,
      this.textStyle,
      this.labelStyle,
      this.decoration,
      this.focusBorderColor,
      this.canTapOutside,
      this.onFieldSubmitted,
      this.cursorColor,
      this.textInputAction});

  @override
  State<TextFieldUI> createState() => _TextFieldUIState();
}

class _TextFieldUIState extends State<TextFieldUI> {
  bool isShowPass = false;
  late final FocusNode focusNode = widget.focusNode ?? FocusNode();

  late bool isExpand = (widget.height ?? 0) >= 60;

  @override
  void initState() {
    handleFormatCurrency();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    borderColor = widget.enable != false
        ? (widget.borderColor ?? Colors.grey)
        : Colors.grey;
    borderErrorColor = widget.enable != false ? Colors.red : Colors.grey;

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: painterChild,
    );
  }

  Widget get painterChild => widget.painter != null
      ? CustomPaint(
          painter: widget.painter,
          child: fixedSizeChild,
        )
      : fixedSizeChild;

  Widget get fixedSizeChild => widget.maxHeight != null ||
          widget.maxWidth != null ||
          widget.minHeight != null ||
          widget.minWidth != null
      ? ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth ?? double.infinity,
            maxHeight: widget.minHeight ?? double.infinity,
            minHeight: widget.minHeight ?? 0,
            minWidth: widget.minWidth ?? 0,
          ),
          child: wrapChild,
        )
      : wrapChild;

  Widget get wrapChild => widget.wrapWidth != null
      ? IntrinsicWidth(
          child: textField,
        )
      : textField;

  Widget get textField => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.required != null) ...[
            RichText(
              maxLines: widget.titleMaxLines,
              overflow: widget.titleMaxLines != null
                  ? TextOverflow.ellipsis
                  : TextOverflow.clip,
              text: TextSpan(children: [
                TextSpan(
                  text: widget.required == true ? "*" : "",
                  style: labelStyle.copyWith(color: Colors.red),
                ),
                TextSpan(
                  text: widget.title ?? "",
                  style: labelStyle,
                ),
              ]),
            ),
            const SizedBox(
              height: 6,
            ),
          ],
          SizedBox(
            height: widget.height,
            width: widget.width,
            child: TextFormField(
              cursorColor: widget.cursorColor,
              textInputAction: widget.textInputAction,
              validator: widget.validator,
              keyboardType: widget.inputType,
              controller: widget.controller,
              expands: isExpand,
              maxLines: widget.isPassword == true
                  ? 1
                  : (isExpand
                      ? null
                      : (widget.height != null ? 1 : widget.maxLines)),
              minLines: isExpand ? null : (widget.minLines ?? 1),
              maxLength: widget.maxLength,
              focusNode: focusNode,
              style: textStyle,
              textAlign: widget.textAlign ?? TextAlign.start,
              textAlignVertical: isExpand ? TextAlignVertical.top : null,
              readOnly:
                  widget.enable == false ? true : (widget.readOnly ?? false),
              onTapOutside: widget.canTapOutside == true
                  ? (event) {
                      focusNode.unfocus();
                    }
                  : null,
              onTap: () {
                if (widget.onTap != null && widget.enable != false) {
                  widget.onTap!();
                }
              },
              onFieldSubmitted: widget.onFieldSubmitted,
              obscureText: widget.isPassword == true ? !isShowPass : false,
              onChanged: (s) {
                String value = s;
                if (widget.formatCurrency == true) {
                  /// unFormat currency when result value
                  value = NumericTextFormatter.unFormatCurrencyVN(value);
                }
                if (widget.onChange != null) widget.onChange!(value);
              },
              inputFormatters:
                  widget.formatCurrency == true ? [NumericTextFormatter()] : [],
              decoration: widget.decoration?.copyWith(
                    hintText: widget.hint,
                  ) ??
                  InputDecoration(
                    counterText: '',
                    counter: null,
                    isDense: true,
                    labelText: widget.label,
                    hintText: widget.hint,
                    hintMaxLines: 1,
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                    filled: true,
                    suffixIconColor: Colors.grey,
                    fillColor: widget.backgroundColor ??
                        (widget.enable != false
                            ? Colors.white
                            : Colors.grey.shade200),
                    prefixIcon: widget.icon,
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 35, minWidth: 35),
                    suffixIcon: widget.isPassword == true
                        ? IconButton(
                            visualDensity: const VisualDensity(vertical: -4),
                            onPressed: () {
                              setState(() {
                                isShowPass = !isShowPass;
                              });
                            },
                            icon: Icon(
                              isShowPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          )
                        : widget.suffixIcon,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                        borderSide: widget.focusBorderColor != null
                            ? BorderSide(
                                color: widget.focusBorderColor!,
                                width: border.borderSide.width + 0.5,
                              )
                            : null),
                    border: border,
                    errorBorder: errorBorder,
                  ),
            ),
          )
        ],
      );

  late Color borderColor;
  late Color borderErrorColor;

  InputBorder get border =>
      widget.inputBorder ??
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(color: borderColor));

  InputBorder get errorBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
      borderSide: BorderSide(color: borderErrorColor));

  void handleFormatCurrency() {
    // if(widget.formatCurrency == true && (widget.enable == false || widget.readOnly == true)){
    if (widget.formatCurrency == true) {
      // format currency when setText into controller
      widget.controller?.addListener(() {
        widget.controller?.value = TextEditingValue(
          text: NumericTextFormatter.formatCurrencyVN(widget.controller?.text),
          selection: TextSelection.collapsed(
              offset: widget.controller?.text.length ?? 0),
        );
      });
    }

    /// format currency when first create
    if (widget.formatCurrency == true) {
      widget.controller?.value = TextEditingValue(
        text: NumericTextFormatter.formatCurrencyVN(widget.controller?.text),
        selection: TextSelection.collapsed(
            offset: widget.controller?.text.length ?? 0),
      );
    }
  }

  late TextStyle textStyle = widget.textStyle ??
      const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400);

  late TextStyle labelStyle = widget.labelStyle ??
      const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500);

  late TextStyle hintStyle = widget.hintStyle ??
      TextStyle(
          fontSize: 16,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w400);
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;

      final newString = formatCurrencyVN(newValue.text);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }

  static String formatCurrencyVN(String? value) {
    if (value == null) return "";

    int? number = double.tryParse(value)?.toInt();
    if (number == null) return "";

    String result = "";
    int i = 0;
    while (number != 0) {
      if (result.isNotEmpty && i % 3 == 0) result += ",";
      result += "${number! % 10}";
      number = number ~/ 10;
      i++;
    }
    return result.toString().split("").reversed.join("");
  }

  static String unFormatCurrencyVN(String? value) {
    if (value == null) return "";
    return value.replaceAll(',', '');
  }
}
