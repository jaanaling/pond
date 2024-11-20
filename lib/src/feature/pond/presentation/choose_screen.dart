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

class ChooseScreen extends StatelessWidget {
  final ChooseType type;
  const ChooseScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PondBloc, PondState>(
      builder: (context, state) {
        if (state is PondLoaded) {
          final list = type == ChooseType.decorations
              ? state.decorations
              : type == ChooseType.fish
                  ? state.fish
                  : state.plants;
          print(list.length);
          return Column(
            children: [
              AppBarWidget(
                title:
                    'Choose ${type == ChooseType.decorations ? 'Decorations' : type == ChooseType.fish ? 'Fish' : 'Plants'}',
                hasBackIcon: true,
              ),
              const Gap(26),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: list.map((item) {
                    return ElementWidget(
                      element: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class ElementWidget extends StatelessWidget {
  final dynamic element;
  const ElementWidget({super.key, this.element});

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

    return AppButton(
      color: type == ChooseType.decorations
          ? ButtonColors.pink
          : type == ChooseType.fish
              ? ButtonColors.blue
              : ButtonColors.green,
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            AppIcon(asset: imageUrl ?? ''),
            Gap(9),
            Text(
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
            Gap(8),
          ],
        ),
      ),
    );
  }
}

enum ChooseType { plants, fish, decorations }
