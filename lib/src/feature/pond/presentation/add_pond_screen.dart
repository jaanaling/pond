import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/presentation/choose_screen.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';
import 'package:pond_care/ui_kit/text_field/text_field.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pond_care/src/feature/pond/models/fish.dart';

import '../models/decoration.dart';
import '../models/plant.dart';

List<Fish> selectedFish = [];
List<Decorations> selectedDecorations = [];
List<Plant> selectedPlants = [];

class AddPondScreen extends StatefulWidget {
  const AddPondScreen({super.key});

  @override
  State<AddPondScreen> createState() => _AddPondScreenState();
}

class _AddPondScreenState extends State<AddPondScreen> {
  final _nameController = TextEditingController();
  final _volumeController = TextEditingController();
  String? _image;

  final ImagePicker _picker = ImagePicker(); // Экземпляр ImagePicker

  Future<void> _pickImage() async {
    // Открываем галерею для выбора изображения
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path; // Сохраняем выбранное изображение
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.shortestSide >= 600;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 12, top: 27),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 12),
                        child: _image == null
                            ? AppButton(
                                onPressed: _pickImage,
                                color: ButtonColors.green,
                                radius: 17,
                                widget: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: AppIcon(
                                    asset: IconProvider.photo.buildImageUrl(),
                                    width: 66,
                                    height: 58,
                                  ),
                                ))
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17)),
                                child: Image.file(
                                  File(_image!),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: AppButton(
                          onPressed: _pickImage,
                          color: ButtonColors.lightBlue,
                          widget: SizedBox(
                            width: 52,
                            height: 44,
                            child: Center(
                              child: AppIcon(
                                asset: IconProvider.add.buildImageUrl(),
                                width: 21,
                                height: 21,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Upload Pond${isIpad ? ' ' : '\n'}Photo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontFamily: 'Araside',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            const Text(
              'Enter Pond Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Araside',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AppTextField(
                controller: _nameController,
                height: 78,
              ),
            ),
            const Gap(21),
            Align(
              child: Text(
                'Enter Pond Volume${isIpad ? ' ' : '\n'}(in Liters)',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Araside',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            AppTextField(
              controller: _volumeController,
              onChanged: (value) {
                // Заменяем запятую на точку
                String newText = value.replaceAll(',', '.');

                // Проверяем, что в строке больше одной точки
                if (newText.split('.').length - 1 > 1) {
                  // Убираем все точки, кроме самой первой
                  final int firstDotIndex = newText.indexOf('.');
                  newText = newText.substring(0, firstDotIndex + 1) +
                      newText.substring(firstDotIndex + 1).replaceAll('.', '');
                }

                // Ограничиваем ввод до восьми цифр до точки и трех после
                if (newText.isNotEmpty &&
                    !RegExp(r'^\d{0,8}(\.\d{0,3})?$').hasMatch(newText)) {
                  final int dotIndex = newText.indexOf('.');

                  if (dotIndex != -1) {
                    final String beforeDot = newText.substring(0, dotIndex);
                    final String afterDot = newText.substring(dotIndex + 1);

                    // Ограничиваем ввод
                    newText = '${beforeDot.substring(
                      0,
                      beforeDot.length > 8 ? 8 : beforeDot.length,
                    )}.${afterDot.substring(
                      0,
                      afterDot.length > 3 ? 3 : afterDot.length,
                    )}';
                  } else {
                    newText = newText.substring(
                      0,
                      newText.length > 8 ? 8 : newText.length,
                    );
                  }
                }

                // Обновляем текст только если он изменился
                if (newText != value) {
                  _volumeController.text = newText;
                  _volumeController.selection = TextSelection.fromPosition(
                    TextPosition(offset: newText.length),
                  );
                }
              },
              height: 52,
              width: MediaQuery.of(context).size.width * 0.39,
              textInputType: TextInputType.number,
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChooseButton(
                  text: 'Choose Plants',
                  onPressed: () {
                    context.push(
                      '${RouteValue.home.path}/${RouteValue.addPond.path}/${RouteValue.choose.path}',
                      extra: ChooseType.plants,
                    );
                  },
                ),
                ChooseButton(
                  text: 'Choose Decorations',
                  fontSize: 17,
                  onPressed: () {
                    context.push(
                      '${RouteValue.home.path}/${RouteValue.addPond.path}/${RouteValue.choose.path}',
                      extra: ChooseType.decorations,
                    );
                  },
                ),
              ],
            ),
            const Gap(21),
            ChooseButton(
              text: 'Choose${isIpad ? ' ' : '\n'}Fish',
              onPressed: () {
                context.push(
                  '${RouteValue.home.path}/${RouteValue.addPond.path}/${RouteValue.choose.path}',
                  extra: ChooseType.fish,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: AppButton(
                onPressed: () {},
                color: ButtonColors.green,
                widget: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 54),
                  child: Text(
                    'Add Pond',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 31,
                      fontFamily: 'Araside',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double fontSize;

  const ChooseButton({
    super.key,
    required this.text,
    this.onPressed,
    this.fontSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.white,
        // onPressed: onPressed,
        // padding: EdgeInsets.zero,
        child: Ink(
          width: MediaQuery.of(context).size.width * 0.466,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Color(0xFF476586)),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Ink(
              width: MediaQuery.of(context).size.width * 0.466,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFDEEBFC),
                    Color(0xFFC3E5FE),
                    Color(0xFF476586),
                  ],
                  stops: [
                    0.6,
                    0.9,
                    1,
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: 'Araside',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: 'Araside',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = const Color(0xFF3256A2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
