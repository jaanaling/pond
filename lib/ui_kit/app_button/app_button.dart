import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final ButtonColors color;
  final Widget widget;
  final VoidCallback? onPressed;
  final double radius;
  final double? width;

  const AppButton({
    super.key,
    required this.color,
    required this.widget,
    this.onPressed,
    this.radius = 32,
    this.width,
  });

  List<Color> generateShades(Color color) {
    HSLColor hsl = HSLColor.fromColor(color);

    // Создаем 4 оттенка, изменяя светлоту
    return [
      hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0)).toColor(),
      hsl.withLightness((hsl.lightness + 0.1).clamp(0.0, 1.0)).toColor(),
      hsl.toColor(),
      hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        width: width == 0 ? null : width ?? double.infinity,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              if (color == ButtonColors.green)
                const Color.fromRGBO(131, 237, 132, 1.0)
              else
                color == ButtonColors.purple
                    ? const Color.fromRGBO(209, 132, 238, 1.0)
                    : color == ButtonColors.yellow
                        ? const Color.fromRGBO(227, 182, 93, 1.0)
                        : const Color.fromRGBO(245, 245, 245, 1.0),
              if (color == ButtonColors.green)
                const Color.fromRGBO(26, 139, 12, 1.0)
              else
                color == ButtonColors.purple
                    ? const Color.fromRGBO(91, 8, 139, 1.0)
                    : color == ButtonColors.yellow
                        ? const Color.fromRGBO(145, 83, 11, 1.0)
                        : const Color.fromRGBO(164, 164, 164, 1.0),
            ],
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFFFDD6D),
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: color == ButtonColors.green ? 6.0 : 3.0,
              bottom: color == ButtonColors.green ? 7.0 : 4.0),
          child: Container(
            width: width == 0 ? null : width ?? double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: color == ButtonColors.green
                    ? [
                        const Color(0xFF52E252),
                        const Color(0xFF53FF5F),
                        const Color(0xFF0EDD1C),
                        const Color(0xFF299B00),
                      ]
                    : color == ButtonColors.purple
                        ? [
                            const Color(0xFFB452E2),
                            const Color(0xFFE253FF),
                            const Color(0xFFB30EDD),
                            const Color(0xFF6A009B),
                          ]
                        : color == ButtonColors.yellow
                            ? [
                                const Color(0xFFFFCB3C),
                                const Color(0xFFFFE553),
                                const Color(0xFFF2D010),
                                const Color(0xFFD1920C),
                              ]
                            : [
                                const Color(0xFFEFEFEF),
                                Colors.white,
                                const Color(0xFFEBEBEB),
                                const Color(0xFFE3E3E3),
                              ],
                stops: const [0.0, 0.20, 0.25, 1.0],
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: widget,
          ),
        ),
      ),
    );
  }
}

enum ButtonColors { green, yellow, purple, white }
