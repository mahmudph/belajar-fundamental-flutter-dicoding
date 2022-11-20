/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

/*
 * Created by mahmud on Sat Sep 03 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchFieldWidget extends StatefulWidget {
  final VoidCallback onTapSearchPannel;
  final Color? fillColor;
  final Color? borderColor;
  final bool autoFocus, enableClearButton;
  final Function(String e)? onSeachCallback;
  final String hint;
  const SearchFieldWidget({
    Key? key,
    this.borderColor,
    this.fillColor,
    this.hint = 'Search Restaurant',
    this.enableClearButton = false,
    this.onSeachCallback,
    this.autoFocus = false,
    required this.onTapSearchPannel,
  }) : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  late TextEditingController _controller;
  bool shouldShowClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.onSeachCallback != null) {
      _controller.addListener(() {
        if (widget.enableClearButton &&
            _controller.text.isNotEmpty &&
            !shouldShowClearButton) {
          setState(
            () => shouldShowClearButton = true,
          );
        }
        widget.onSeachCallback!(_controller.text);
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  Widget? suffixIconWidget() {
    if (widget.enableClearButton) {
      if (_controller.text.isNotEmpty) {
        return InkWell(
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.secondary,
            size: 22.px,
          ),
          onTap: () {
            _controller.clear();
          },
        );
      }
    }
    return null;
  }

  OutlineInputBorder getBorderRadius(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: _controller,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onTap: widget.onTapSearchPannel,
      enabled: true,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: widget.fillColor ?? Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.px,
          horizontal: 14.px,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: colorScheme.primary,
          size: 24.px,
        ),
        suffixIcon: shouldShowClearButton
            ? InkWell(
                child: Icon(
                  Icons.close,
                  color: colorScheme.primary,
                  size: 22.px,
                ),
                onTap: () {
                  setState(() => shouldShowClearButton = false);
                  _controller.clear();
                },
              )
            : null,
        hintText: widget.hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.px,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: colorScheme.primary.withOpacity(0.3),
          ),
        ),
        enabledBorder: getBorderRadius(
          widget.borderColor ?? colorScheme.primary.withOpacity(0.3),
        ),
        errorBorder: getBorderRadius(
          widget.borderColor ?? colorScheme.error,
        ),
        focusedBorder: getBorderRadius(
          widget.borderColor ?? colorScheme.primary.withOpacity(0.3),
        ),
      ),
    );
  }
}
