import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/decoration.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

import '../models/fish.dart';
import '../models/plant.dart';
import 'add_pond_screen.dart';

class ChooseScreen extends StatefulWidget {
  final ChooseType type;
  const ChooseScreen({super.key, required this.type});

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  List<Object> _sortedList = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: BlocBuilder<PondBloc, PondState>(
            builder: (context, state) {
              if (state is PondLoaded) {
                if(_sortedList.isEmpty){
                  _sortedList = (widget.type == ChooseType.decorations
                      ? state.decorations
                      : widget.type == ChooseType.fish
                      ? state.fish
                      : state.plants)
                    ..sort((a, b) {
                      final aSelected = isSelected(
                        item: a,
                        type: widget.type,
                      ) ? 1 : 0;
                      final bSelected = isSelected(
                        item: b,
                        type: widget.type,
                      ) ? 1 : 0;
                      return bSelected - aSelected;
                    });
                }

                return Column(
                  children: [
                    const Gap(150),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: _sortedList.map((item) {
                          return ElementWidget(
                            element: item,
                            isSelected:
                                isSelected(item: item, type: widget.type),
                            onSelectionChange: () {
                              setState(() {
                                if (widget.type == ChooseType.decorations &&
                                    item is Decorations) {
                                  if (selectedDecorations.any(
                                    (decoration) => decoration.id == item.id,
                                  )) {
                                    selectedDecorations.removeWhere(
                                      (decoration) => decoration.id == item.id,
                                    );
                                  } else {
                                    selectedDecorations.add(item);
                                  }
                                } else if (widget.type == ChooseType.fish &&
                                    item is Fish) {
                                  if (selectedFish
                                      .any((fish) => fish.id == item.id)) {
                                    selectedFish.removeWhere(
                                      (fish) => fish.id == item.id,
                                    );
                                  } else {
                                    selectedFish.add(item);
                                  }
                                } else if (widget.type == ChooseType.plants &&
                                    item is Plant) {
                                  if (selectedPlants
                                      .any((plant) => plant.id == item.id)) {
                                    selectedPlants.removeWhere(
                                      (plant) => plant.id == item.id,
                                    );
                                  } else {
                                    selectedPlants.add(item);
                                  }
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Gap(16),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        AppBarWidget(
          title:
              'Choose ${widget.type == ChooseType.decorations ? 'Decorations' : widget.type == ChooseType.fish ? 'Fish' : 'Plants'}',
          hasBackIcon: true,
        ),
      ],
    );
  }
}

bool isSelected({
  required Object item,
  required ChooseType type,
}) {
  if (type == ChooseType.decorations && item is Decorations) {
    return selectedDecorations.any((decoration) => decoration.id == item.id);
  } else if (type == ChooseType.fish && item is Fish) {
    return selectedFish.any((fish) => fish.id == item.id);
  } else if (type == ChooseType.plants && item is Plant) {
    return selectedPlants.any((plant) => plant.id == item.id);
  }
  return false;
}

class ElementWidget extends StatelessWidget {
  final dynamic element;
  final bool isSelected;
  final VoidCallback onSelectionChange;
  const ElementWidget({
    super.key,
    this.element,
    required this.isSelected,
    required this.onSelectionChange,
  });

  @override
  Widget build(BuildContext context) {
    final type = element is Decorations
        ? ChooseType.decorations
        : element is Plant
            ? ChooseType.plants
            : ChooseType.fish;

    late final String? imageUrl;
    late final String name;

    if (type == ChooseType.decorations) {
      imageUrl = (element as Decorations).imageUrl;
      name = (element as Decorations).name;
    } else if (type == ChooseType.fish) {
      imageUrl = (element as Fish).imageUrl;
      name = (element as Fish).name;
    } else {
      imageUrl = (element as Plant).imageUrl;
      name = (element as Plant).name;
    }

    return Stack(
      children: [
        AppButton(
          color: type == ChooseType.decorations
              ? ButtonColors.pink
              : type == ChooseType.fish
                  ? ButtonColors.blue
                  : ButtonColors.green,
          radius: 17,
          width: 142,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                AppIcon(asset: imageUrl ?? ''),
                Gap(9),
                SizedBox(
                  height: 44,
                  width: 137,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Araside',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Gap(8),
              ],
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSelectionChange,
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.00, 1.00),
                        end: Alignment(0, -1),
                        colors: [Color(0xFFD9D9D9), Color(0xFFA2A2A2)],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFF999999)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  AnimatedScale(
                    scale: isSelected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.00, 1.00),
                          end: Alignment(0, -1),
                          colors: [Color(0xFF0096F4), Color(0xFF48C8FF)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum ChooseType { plants, fish, decorations }
