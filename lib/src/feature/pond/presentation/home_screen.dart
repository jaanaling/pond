import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/routes/go_router_config.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

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
