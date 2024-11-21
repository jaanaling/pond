import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/src/feature/pond/presentation/choose_screen.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';
import 'package:pond_care/ui_kit/text_field/text_field.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pond_care/src/feature/pond/models/fish.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../models/decoration.dart';
import '../models/plant.dart';

List<Fish> selectedFish = [];
List<Decorations> selectedDecorations = [];
List<Plant> selectedPlants = [];
final _nameController = TextEditingController();
final _volumeController = TextEditingController();

class AddPondScreen extends StatefulWidget {
  final Pond? pond;
  const AddPondScreen({super.key, this.pond});

  @override
  State<AddPondScreen> createState() => _AddPondScreenState();
}

class _AddPondScreenState extends State<AddPondScreen> {
  late bool isFirstTime;
  String? _image;

  final ImagePicker _picker = ImagePicker(); // Экземпляр ImagePicker

  @override
  void initState() {
    super.initState();
    if (widget.pond != null) {
      _nameController.text = widget.pond!.name;
      _volumeController.text = widget.pond!.volume.toString();
      _image = widget.pond!.photoUrl;
      selectedFish = widget.pond!.fish;
      selectedPlants = widget.pond!.plants;
      selectedDecorations = widget.pond!.decorations;
    }
  }

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

  Map<String, int> calculateMaxElementsBySize() {
    final int maxUnits = (_volumeController.text.isNotEmpty
            ? double.parse(_volumeController.text) / 50
            : 0)
        .floor(); // Каждая условная единица требует 50 литров воды
    final int currentFishUnits =
        selectedFish.fold(0, (sum, f) => sum + _getSizeUnit(f.size));
    final int currentPlantUnits =
        selectedPlants.fold(0, (sum, p) => sum + _getSizeUnit(p.size));
    final int currentDecorationUnits =
        selectedDecorations.fold(0, (sum, d) => sum + _getSizeUnit(d.size));

    return {
      'maxUnits': maxUnits,
      'currentFishUnits': currentFishUnits,
      'currentPlantUnits': currentPlantUnits,
      'currentDecorationUnits': currentDecorationUnits,
    };
  }

  int _getSizeUnit(String size) {
    switch (size) {
      case 'small':
        return 1;
      case 'medium':
        return 2;
      case 'large':
        return 3;
      default:
        return 1;
    }
  }

  String? checkElementCountsBySize() {
    String? warnings;
    final Map<String, int> sizeData = calculateMaxElementsBySize();

    if (sizeData['currentFishUnits']! +
            sizeData['currentPlantUnits']! +
            sizeData['currentDecorationUnits']! >
        sizeData['maxUnits']!) {
      warnings = 'The elements take up too much space. '
          'Try expanding the pond size or removing elements from it.';
    }

    return _volumeController.text.isNotEmpty ? warnings : null;
  }

  bool isTextError = false;
  bool isValueError = false;
  bool isFishError = false;

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.shortestSide >= 600;
    return Stack(
      children: [
        SingleChildScrollView(
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
                            padding:
                                const EdgeInsets.only(right: 12, bottom: 12),
                            child: _image == null
                                ? AppButton(
                                    onPressed: _pickImage,
                                    color: ButtonColors.green,
                                    radius: 17,
                                    widget: SizedBox(
                                      width: 130,
                                      height: 130,
                                      child: Center(
                                        child: AppIcon(
                                          asset: IconProvider.photo
                                              .buildImageUrl(),
                                          width: 66,
                                          height: 58,
                                        ),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(17)),
                                    child: Image.file(
                                      File(_image!),
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
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
                          newText
                              .substring(firstDotIndex + 1)
                              .replaceAll('.', '');
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

                    setState(() {

                    });
                  },
                  height: 52,
                  width: MediaQuery.of(context).size.width * 0.39,
                  textInputType: TextInputType.number,
                ),
                if (checkElementCountsBySize() != null) const Gap(24),
                if (checkElementCountsBySize() != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          IconProvider.error.buildImageUrl(),
                          width: 62,
                          height: 62,
                        ),
                        const Gap(4),
                        Expanded(
                            child: Text(
                          checkElementCountsBySize()!,
                          style: TextStyle(fontFamily: 'Baby Bears'),
                        )),
                      ],
                    ),
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
                    onPressed: () {
                      if (_nameController.text.isEmpty) {
                        setState(() {
                          isTextError = true;
                        });
                      } else {
                        setState(() {
                          isTextError = false;
                        });
                      }

                      if (_volumeController.text.isEmpty) {
                        setState(() {
                          isValueError = true;
                        });
                      } else {
                        setState(() {
                          isValueError = false;
                        });
                      }
                      if (selectedFish.isEmpty) {
                        setState(() {
                          isFishError = true;
                        });
                      } else {
                        setState(() {
                          isFishError = false;
                        });
                      }

                      if (isTextError || isValueError || isFishError) {
                        return;
                      }

                      if (widget.pond != null) {
                        context.read<PondBloc>().add(
                              UpdatePond(
                                Pond(
                                  id: widget.pond!.id,
                                  photoUrl: _image,
                                  name: _nameController.text,
                                  volume: _volumeController.text.isNotEmpty
                                      ? double.parse(_volumeController.text)
                                      : 0,
                                  fish: [...selectedFish],
                                  tasks: [...?widget.pond!.tasks],
                                  plants: [...selectedPlants],
                                  decorations: [...selectedDecorations],
                                ),
                              ),
                            );
                      } else {
                        context.read<PondBloc>().add(
                              SavePond(
                                Pond(
                                  id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  photoUrl: _image,
                                  name: _nameController.text,
                                  volume: _volumeController.text.isNotEmpty
                                      ? double.parse(_volumeController.text)
                                      : 0,
                                  fish: [...selectedFish],
                                  tasks: [],
                                  plants: [...selectedPlants],
                                  decorations: [...selectedDecorations],
                                ),
                              ),
                            );
                      }

                      selectedFish.clear();
                      selectedDecorations.clear();
                      selectedPlants.clear();
                      _nameController.clear();
                      _volumeController.clear();

                      context.pop();
                    },
                    color: ButtonColors.green,
                    widget: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 54),
                      child: Text(
                        widget.pond != null ? 'Update Pond' : 'Add Pond',
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
                const Gap(24),
                if (isTextError)
                  Text("Pond Name can't be empty",
                      style: TextStyle(
                          fontFamily: 'Baby Bears',
                          color: CupertinoColors.systemRed)),
                const Gap(8),
                if (isValueError)
                  Text("Pond Volume can't be empty",
                      style: TextStyle(
                          fontFamily: 'Baby Bears',
                          color: CupertinoColors.systemRed)),
                const Gap(8),
                if (isFishError)
                  Text("You must choose at least one fish",
                      style: TextStyle(
                          fontFamily: 'Baby Bears',
                          color: CupertinoColors.systemRed))
              ],
            ),
          ),
        ),
        if (widget.pond != null ? !isEditScreenLoaded : !isCreateScreenLoaded)
          Stack(alignment: Alignment.topCenter, children: [
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6799999833106995),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.147 -
                        MediaQuery.of(context).padding.top),
                    Text(
                      widget.pond == null
                          ? 'WELCOME TO YOUR POND CREATION!'
                          : 'LET’S EDIT YOUR POND!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 33,
                        fontFamily: 'Araside',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(10),
                    Text(
                      widget.pond == null
                          ? 'Here, you can set up your pond by providing a name, volume, and select fish, plants, and decorations!'
                          : 'You can change the pond name, volume, and update the fish, plants, and decorations here!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'Baby Bears',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -(MediaQuery.of(context).size.height * 0.108),
              child: AppIcon(
                asset: widget.pond == null
                    ? IconProvider.masqot1.buildImageUrl()
                    : IconProvider.masqot3.buildImageUrl(),
                width: MediaQuery.of(context).size.width * 0.986,
                height: MediaQuery.of(context).size.height * 0.73,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 104),
                child: AppButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool(
                        widget.pond == null ? 'createScreen' : 'editScreen',
                        true);

                    setState(() {
                      if (widget.pond == null) {
                        isCreateScreenLoaded = true;
                      } else {
                        isEditScreenLoaded = true;
                      }
                    });
                  },
                  color: ButtonColors.green,
                  widget: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 54),
                    child: Text(
                      'Got It!',
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
            ),
          ]),
      ],
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
