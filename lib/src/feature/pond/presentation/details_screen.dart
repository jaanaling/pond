import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

class DetailsScreen extends StatelessWidget {
  final Pond pondd;
  const DetailsScreen({required this.pondd, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PondBloc, PondState>(
      builder: (context, state) {
        if (state is PondLoaded) {
          final pond =
              state.pond.firstWhere((element) => element.id == pondd.id);
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Padding(
                  padding: const EdgeInsets.only(top: 139),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11),
                              child: Stack(
                                children: [
                                  pond.photoUrl == null
                                      ? AppButton(
                                          color: ButtonColors.green,
                                          radius: 17,
                                          widget: Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: AppIcon(
                                              asset: IconProvider.photo
                                                  .buildImageUrl(),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          child: Image.file(
                                            File(pond.photoUrl!),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        pond.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Araside',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        'Pond volume: ${pond.volume} l.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Baby Bears',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Active Tasks: ${pond.tasks?.length ?? 0}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Baby Bears',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    'Overdue Tasks: ${pond.tasks?.where((task) => task.dueDate != null && task.dueDate!.isBefore(DateTime.now())).length ?? 0}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Baby Bears',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(16),
                        Row(
                          children: [
                            AppButton(
                              color: ButtonColors.lightBlue,
                              widget: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Image.asset(
                                  IconProvider.fish.buildImageUrl(),
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ),
                            Gap(16),
                            Text(
                              '${pond.fish.length.toString()} fishs',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Baby Bears',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        Gap(16),
                        Row(
                          children: [
                            AppButton(
                              color: ButtonColors.pink,
                              widget: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Image.asset(
                                  IconProvider.decor.buildImageUrl(),
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ),
                            Gap(16),
                            Text(
                              pond.decorations.length.toString() +
                                  ' decorations',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Baby Bears',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        Gap(16),
                        Row(
                          children: [
                            AppButton(
                              color: ButtonColors.green,
                              widget: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Icon(
                                  Icons.grass,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Gap(16),
                            Text(
                              pond.plants.length.toString() + ' plants',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Baby Bears',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        Gap(16),
                        ListView.separated(
                          itemCount: pond.getRecommendations().entries.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Gap(16),
                          itemBuilder: (context, index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconProvider.alert.buildImageUrl(),
                                width: 50,
                                height: 50,
                              ),
                              Gap(16),
                              Expanded(
                                child: Text(
                                  pond
                                      .getRecommendations()
                                      .entries
                                      .elementAt(index)
                                      .value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(16),
                        ListView.separated(
                          itemCount: pond.getErrors().entries.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Gap(16),
                          itemBuilder: (context, index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconProvider.error.buildImageUrl(),
                                width: 50,
                                height: 50,
                              ),
                              Gap(16),
                              Expanded(
                                child: Text(
                                  pond
                                      .getErrors()
                                      .entries
                                      .elementAt(index)
                                      .value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppButton(
                                color: ButtonColors.green,
                                onPressed: () => context.push(
                                  "${RouteValue.home.path}/${RouteValue.details.path}/${RouteValue.addPond.path}",
                                  extra: pond,
                                ),
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 16),
                                  child: Text(
                                    'Edit Pond',
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
                              Gap(16),
                              AppButton(
                                color: ButtonColors.blue,
                                onPressed: () => context.push(
                                  "${RouteValue.home.path}/${RouteValue.details.path}/${RouteValue.tasks.path}",
                                  extra: pond,
                                ),
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 16),
                                  child: Text(
                                    'View Tasks',
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
                              Gap(16),
                              AppButton(
                                color: ButtonColors.red,
                                onPressed: () =>
                                    showDialog(context, pond: pond),
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 16),
                                  child: Text(
                                    'Delete Pond',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppBarWidget(
                title: 'Pond Details',
                hasBackIcon: true,
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<dynamic> showDialog(BuildContext context, {required Pond pond}) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 150,
            child: AppButton(
              color: ButtonColors.green,
              widget: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      titleAlert("Delte this pond?"),
                      const Gap(36),
                      RowButtons(context, pond: pond),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Text titleAlert(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontFamily: 'Araside',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
    );
  }

  Row RowButtons(BuildContext context, {required Pond pond}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          width: MediaQuery.of(context).size.width * 0.25,
          color: ButtonColors.blue,
          onPressed: () => Navigator.of(context).pop(),
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              'Close',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Araside',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
        const Gap(16),
        AppButton(
          width: MediaQuery.of(context).size.width * 0.4,
          color: ButtonColors.red,
          onPressed: () {
            context.read<PondBloc>().add(RemovePond(pond));
            Navigator.of(context).pop();
            context.pop();
          },
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Delete',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Araside',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
