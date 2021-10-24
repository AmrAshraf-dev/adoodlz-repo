import 'package:flutter/material.dart';

class CustomRaisedButton extends StatefulWidget {
  const CustomRaisedButton({
    Key key,
    this.loading = false,
    @required this.onPressed,
    @required this.label,
    this.leading,
    this.lightFont = false,
    this.height = 46,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.textStyle,
    this.colors
  }) : super(key: key);

  final bool loading;
  final String label;
  final Function onPressed;
  final Widget leading;
  final bool lightFont;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color colors;

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color:  widget.colors ?? theme.accentColor,
          // gradient: LinearGradient(
          //     begin: Alignment.centerRight,
          //     end: Alignment.centerLeft,
          //     colors: [
          //       theme.accentColor,
          //       theme.primaryColor,
          //     ]),
        ),
        child: Center(
          child: widget.loading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.leading ?? Container(),
                    if (widget.leading != null) const SizedBox(width: 8),
                    Text(
                      widget.label,
                      style: widget.textStyle ?? theme.textTheme.button.copyWith(
                              fontSize: 15.0,
                              fontWeight: widget.lightFont
                                  ? FontWeight.w600
                                  : FontWeight.w900),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
