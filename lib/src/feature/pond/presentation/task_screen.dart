// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';

import 'package:pond_care/src/feature/pond/models/task.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

class TaskScreen extends StatefulWidget {
  final Pond pond;
  const TaskScreen({
    super.key,
    required this.pond,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isAllTask = true;

  @override
  Widget build(BuildContext context) {
    final tasks = widget.pond.tasks
            ?.where((test) =>
                isAllTask ||
                test.dueDate!.difference(DateTime.now()).inDays < 0)
            .toList() ??
        [];
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 35),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Placeholder(),
            Gap(11),
            AppButton(
              color: ButtonColors.lightBlue,
              widget: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.history,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              onPressed: () => context.push(
                  "${RouteValue.home.path}/${RouteValue.details.path}/${RouteValue.tasks.path}/${RouteValue.history.path}"),
            ),
            Gap(11),
            ListView.separated(
                itemCount: tasks.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Gap(11),
                itemBuilder: (context, index) {
                  return AppButton(
                      width: double.infinity,
                      color: ButtonColors.blue,
                      widget: Column(
                        children: [
                          Text(
                            tasks[index].title,
                          ),
                          Gap(4),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Done in ${tasks[index].dueDate!.difference(DateTime.now()).inDays} days",
                                  ),
                                  tasks[index]
                                              .dueDate!
                                              .difference(DateTime.now())
                                              .inDays <
                                          0
                                      ? Text("Pending")
                                      : Row(
                                          children: [
                                            Image.asset(IconProvider.error
                                                .buildImageUrl()),
                                            Gap(4),
                                            Text("Overdue")
                                          ],
                                        ),
                                ],
                              ),
                              Spacer(),
                              AppButton(
                                  color: ButtonColors.green,
                                  widget: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 11),
                                    child: Text("Complete"),
                                  ),
                                  onPressed: () => context.read<PondBloc>().add(
                                      UpdateTasks(tasks[index], widget.pond)))
                            ],
                          )
                        ],
                      ));
                })
          ],
        ),
      ),
    );
  }
}
