import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/routes/go_router_config.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

import '../../../core/utils/app_icon.dart';
import '../../../core/utils/icon_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(
          title: 'All Ponds',
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 104),
          child: AppButton(
            onPressed: () {
              context
                  .push('${RouteValue.home.path}/${RouteValue.addPond.path}');
            },
            color: ButtonColors.green,
            widget: Padding(
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
    );
  }
}

class PondItem extends StatelessWidget {
  final Pond pond;
  const PondItem({super.key, required this.pond});

  @override
  Widget build(BuildContext context) {
    return AppButton(
        color: ButtonColors.blue,
        widget: Row(
          children: [
            AppButton(
              color: ButtonColors.green,
              radius: 17,
              widget: Padding(
                padding: const EdgeInsets.all(30.0),
                child: AppIcon(
                  asset: IconProvider.photo.buildImageUrl(),
                  width: 59.14,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  pond.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Araside',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Text(
                  'Pond volume: ${pond.volume}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Baby Bears',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Row(
                  children: [
                    AppIcon(asset: IconProvider.fish.buildImageUrl()),
                    Text(
                      pond.fish.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Baby Bears',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
                Text(
                  'Active Tasks: ${pond.tasks}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Baby Bears',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Text(
                  'Pond volume: 123',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Baby Bears',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
