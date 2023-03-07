import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RTextField extends StatefulWidget {
  final void Function(String value)? onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? maxLength;
  final bool showCounter;
  final bool autoFocus;
  final bool? enabled;
  final bool capitalize;
  final TextInputAction? action;
  final void Function(String value)? onDone;
  final FocusNode? focusNode;
  final Widget? suffix;
  final List<TextInputFormatter>? formatters;
  final TextStyle? textStyle;
  final ValueChanged<String>? onEndEditing;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool border;
  final TextAlign? textAlign;
  final bool expand;
  final Color cursorColor, inactiveColor;
  final TextStyle? hintStyle;
  final bool showCursor;
  final bool showEmptyStateWithCursor;
  final String? initialText;
  final EdgeInsets padding;
  final String? errorText;

  const RTextField({
    Key? key,
    this.onChanged,
    this.hint,
    this.maxLines,
    this.prefixIcon,
    this.textInputType,
    this.controller,
    this.maxLength,
    this.showCounter = false,
    this.showCursor = true,
    this.autoFocus = false,
    this.enabled,
    this.capitalize = false,
    this.action,
    this.onDone,
    this.focusNode,
    this.suffix,
    this.formatters,
    this.onEndEditing,
    this.onTap,
    this.readOnly = false,
    this.border = true,
    this.textAlign,
    this.expand = false,
    this.hintStyle,
    this.showEmptyStateWithCursor = false,
    this.initialText,
    this.textStyle,
    this.cursorColor = Colors.red,
    this.padding = const EdgeInsets.all(0),
    this.inactiveColor = Colors.white54,
    this.errorText,
  }) : super(key: key);

  @override
  State<RTextField> createState() => _RTextFieldState();
}

class _RTextFieldState extends State<RTextField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController(text: widget.initialText);
  late final FocusNode _fn = widget.focusNode ?? FocusNode();

  Timer? _timer;

  var active = false;

  @override
  void initState() {
    super.initState();
    _fn.addListener(() {
      setState(() {
        active = _fn.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fn.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = active ? widget.cursorColor : widget.inactiveColor;
    final border = OutlineInputBorder(
      gapPadding: 0,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: widget.border ? color : Colors.transparent),
    );
    final prefixIcon = widget.prefixIcon != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.padding.left),
            child: Icon(
              widget.prefixIcon,
              color: widget.cursorColor,
              // size: textStyle.height! * textStyle.fontSize!,
            ),
          )
        : null;

    return Material(
      color: Colors.transparent,
      child: TextField(
        showCursor: widget.showCursor,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,
        textAlign: widget.textAlign ?? TextAlign.left,
        focusNode: _fn,
        enabled: widget.enabled,
        onSubmitted: widget.onDone,
        scrollPadding: EdgeInsets.zero,
        expands: widget.expand,
        textCapitalization: widget.capitalize
            ? TextCapitalization.words
            : TextCapitalization.none,
        autofocus: widget.autoFocus,
        controller: widget.controller,
        clipBehavior: Clip.none,
        onChanged: (text) {
          widget.onChanged?.call(text);
          _timer?.cancel();
          _timer = Timer(const Duration(milliseconds: 300), () {
            if (mounted) {
              widget.onEndEditing?.call(text);
            }
          });
        },
        maxLength: widget.maxLength,
        inputFormatters: widget.formatters,
        maxLines: widget.expand ? null : widget.maxLines,
        minLines: widget.expand ? null : 1,
        style: widget.textStyle,
        cursorColor: widget.cursorColor,
        keyboardType: widget.textInputType,
        textInputAction: widget.action,
        decoration: InputDecoration(
          isDense: true,
          hintStyle: (widget.hintStyle ?? widget.textStyle),
          hintText: widget.hint,
          prefixIcon: prefixIcon,
          contentPadding: widget.padding,
          prefixIconConstraints: const BoxConstraints(),
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
