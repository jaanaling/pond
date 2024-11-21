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
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

class DetailsScreen extends StatefulWidget {
  final Pond pondd;
  const DetailsScreen({required this.pondd, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PondBloc, PondState>(
      builder: (context, state) {
        if (state is PondLoaded) {
          final pond =
              state.pond.firstWhere((element) => element.id == widget.pondd.id);
          return Stack(
            children: [
              Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Padding(
                      padding: EdgeInsets.only(top: 139+ MediaQuery.of(context).padding.top),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                  ),
                                  child: pond.photoUrl == null
                                      ? AppButton(
                                          color: ButtonColors.green,
                                          radius: 17,
                                          widget: SizedBox(
                                            width: 125,
                                            height: 117,
                                            child: Center(
                                              child: AppIcon(
                                                asset: IconProvider.photo
                                                    .buildImageUrl(),
                                                width: 66,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          child: Image.file(
                                            File(pond.photoUrl!),
                                            width: 125,
                                            height: 117,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 11),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                194,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            pond.name,
                                            style: const TextStyle(
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                194,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Pond volume: ${pond.volume} l.',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
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
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Baby Bears',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      Text(
                                        'Overdue Tasks: ${pond.tasks?.where((task) => task.dueDate != null && task.dueDate!.isBefore(DateTime.now())).length ?? 0}',
                                        style: const TextStyle(
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
                            const Gap(16),
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
                                const Gap(16),
                                Text(
                                  '${pond.fish.length.toString()} fish',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(16),
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
                                const Gap(16),
                                Text(
                                  pond.decorations.length.toString() +
                                      ' decorations',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(16),
                            Row(
                              children: [
                                const AppButton(
                                  color: ButtonColors.green,
                                  widget: Padding(
                                    padding: EdgeInsets.symmetric(
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
                                const Gap(16),
                                Text(
                                  pond.plants.length.toString() + ' plants',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(16),
                            ListView.separated(
                              itemCount:
                                  pond.getRecommendations().entries.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const Gap(16),
                              itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    IconProvider.alert.buildImageUrl(),
                                    width: 50,
                                    height: 50,
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Text(
                                      pond
                                          .getRecommendations()
                                          .entries
                                          .elementAt(index)
                                          .value,
                                      style: const TextStyle(
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
                            const Gap(16),
                            ListView.separated(
                              itemCount: pond.getErrors().entries.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const Gap(16),
                              itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    IconProvider.error.buildImageUrl(),
                                    width: 50,
                                    height: 50,
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Text(
                                      pond
                                          .getErrors()
                                          .entries
                                          .elementAt(index)
                                          .value,
                                      style: const TextStyle(
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
                                    widget: SizedBox(
                                      width: 213,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 11,
                                            horizontal: 16,
                                          ),
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
                                    ),
                                  ),
                                  const Gap(16),
                                  AppButton(
                                    color: ButtonColors.blue,
                                    onPressed: () => context.push(
                                      "${RouteValue.home.path}/${RouteValue.details.path}/${RouteValue.tasks.path}",
                                      extra: pond,
                                    ),
                                    widget: SizedBox(
                                      width: 213,
                                      child: Center(
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 11,
                                          ),
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
                                    ),
                                  ),
                                  const Gap(16),
                                  AppButton(
                                    color: ButtonColors.red,
                                    onPressed: () =>
                                        showDialog(context, pond: pond),
                                    widget: SizedBox(
                                      width: 213,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 11,
                                          ),
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
                  const AppBarWidget(
                    title: 'Pond Details',
                    hasBackIcon: true,
                  ),
                ],
              ),
              if (!isOverviewScreenLoaded)
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
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
                            Gap(
                              MediaQuery.of(context).size.height * 0.147 -
                                  MediaQuery.of(context).padding.top,
                            ),
                            const Text(
                              'WELCOME TO YOUR POND OVERVIEW!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 33,
                                fontFamily: 'Araside',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -(MediaQuery.of(context).size.height * 0.132),
                      child: AppIcon(
                        asset: IconProvider.masqot2.buildImageUrl(),
                        width: MediaQuery.of(context).size.width * 1.163,
                        height: MediaQuery.of(context).size.height * 0.86,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 104),
                        child: AppButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('overviewScreen', true);

                            setState(() {
                              isOverviewScreenLoaded = true;
                            });
                          },
                          color: ButtonColors.green,
                          widget: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 54,
                            ),
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
                  ],
                ),
            ],
          );
        }
        return const CircularProgressIndicator();
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
          widget: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
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
          widget: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Delete',
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
      ],
    );
  }
}
