import 'package:flutter/material.dart';

const double kDefaultMaxWidth = 750;
const double kDefaultCornerRadius = 16;

class CardTile extends StatelessWidget {
  final double? maxWidth;
  final bool topCorner;
  final bool bottomCorner;
  final EdgeInsets? padding;

  final double? cornerRadius;

  final String? titleText;

  //widget before card view. Typically used to show title text.
  final Widget? title;
  final Widget? child;

  const CardTile({
    Key? key,
    this.maxWidth,
    required this.topCorner,
    required this.bottomCorner,
    this.padding,
    this.cornerRadius,
    this.titleText,
    this.title,
    this.child,
  }) : super(key: key);

  factory CardTile.header({
    Key? key,
    final double? maxWidth,
    final EdgeInsets? padding,
    final double? cornerRadius,
    final String? titleText,
    final Widget? title,
    final Widget? child,
  }) {
    return CardTile(
      key: key,
      maxWidth: maxWidth,
      topCorner: true,
      bottomCorner: false,
      padding: padding,
      cornerRadius: cornerRadius,
      title: title,
      titleText: titleText,
      child: child,
    );
  }

  factory CardTile.footer({
    Key? key,
    final double? maxWidth,
    final EdgeInsets? padding,
    final double? cornerRadius,
    final Widget? child,
  }) {
    return CardTile(
      key: key,
      maxWidth: maxWidth,
      topCorner: false,
      bottomCorner: true,
      padding: padding,
      cornerRadius: cornerRadius,
      child: child,
    );
  }

  factory CardTile.tile({
    Key? key,
    final double? maxWidth,
    final EdgeInsets? padding,
    final double? cornerRadius,
    final Widget? child,
  }) {
    return CardTile(
      key: key,
      maxWidth: maxWidth,
      topCorner: false,
      bottomCorner: false,
      padding: padding,
      cornerRadius: cornerRadius,
      child: child,
    );
  }

  factory CardTile.card({
    Key? key,
    final double? maxWidth,
    final EdgeInsets? padding,
    final double? cornerRadius,
    final String? titleText,
    final Widget? title,
    final Widget? child,
  }) {
    return CardTile(
      key: key,
      maxWidth: maxWidth,
      topCorner: true,
      bottomCorner: true,
      padding: padding,
      cornerRadius: cornerRadius,
      title: title,
      titleText: titleText,
      child: child,
    );
  }


  factory CardTile.subtitle({
    Key? key,
    required final String text,
    final bool topCorner = false,
    final double? maxWidth,
    final EdgeInsets? padding,
    final double? cornerRadius,
  }) {
    return CardTile(
      key: key,
      maxWidth: maxWidth,
      padding: padding,
      cornerRadius: cornerRadius,
      topCorner: topCorner,
      bottomCorner: false,
      child: CardTileTitle(text: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = this.padding?.copyWith(
      top: topCorner ? this.padding?.top : 0.0,
      bottom: bottomCorner ? this.padding?.bottom : 0.0,
    ) ??
        EdgeInsets.zero;

    final borderRadius = BorderRadius.only(
      topLeft: topCorner
          ? Radius.circular(cornerRadius ?? kDefaultCornerRadius)
          : Radius.zero,
      topRight: topCorner
          ? Radius.circular(cornerRadius ?? kDefaultCornerRadius)
          : Radius.zero,
      bottomLeft: bottomCorner
          ? Radius.circular(cornerRadius ?? kDefaultCornerRadius)
          : Radius.zero,
      bottomRight: bottomCorner
          ? Radius.circular(cornerRadius ?? kDefaultCornerRadius)
          : Radius.zero,
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: maxWidth ?? kDefaultMaxWidth,
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              if (title != null)
                title!
              else if (titleText != null)
                CardTileTitle(text: titleText!),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                elevation: 0.0,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Material(child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardTileTitle extends StatelessWidget {
  final String text;

  const CardTileTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
