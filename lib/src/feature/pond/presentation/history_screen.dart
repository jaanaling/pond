import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(
          title: "History",
          hasBackIcon: true,
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 35),
          child: SafeArea(
            child: BlocBuilder<PondBloc, PondState>(
              builder: (context, state) {
                if (state is PondLoaded) {
                  final tasks = state.history;
                  return ListView.separated(
                    itemCount: tasks.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(11),
                    itemBuilder: (context, index) {
                      return AppButton(
                        width: double.infinity,
                        color: ButtonColors.blue,
                        widget: Column(
                          children: [
                            Text(
                              "${tasks[index].title} in pond ${state.pond.firstWhere((element) => element.id == tasks[index].pondId)}",
                            ),
                            const Gap(4),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Doned in ${tasks[index].finishDate}',
                                    ),
                                    if (tasks[index]
                                            .dueDate!
                                            .difference(DateTime.now())
                                            .inDays <
                                        0)
                                      const Text('Pending')
                                    else
                                      Row(
                                        children: [
                                          Image.asset(
                                            IconProvider.error.buildImageUrl(),
                                          ),
                                          const Gap(4),
                                          const Text('Overdue'),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
