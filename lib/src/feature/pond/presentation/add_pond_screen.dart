import 'package:flutter/cupertino.dart';
import 'package:pond_care/ui_kit/text_field/text_field.dart';

class AddPondScreen extends StatefulWidget {
  const AddPondScreen({super.key});

  @override
  State<AddPondScreen> createState() => _AddPondScreenState();
}

class _AddPondScreenState extends State<AddPondScreen> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppTextField(controller: _nameController, height: 78,)
        ],
      ),
    );
  }
}
