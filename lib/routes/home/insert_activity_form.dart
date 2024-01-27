import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InsertActivityForm extends HookWidget {
  const InsertActivityForm({super.key});

  @override
  Widget build(BuildContext context) {
    final editingName = useTextEditingController();
    final editingEmoji = useTextEditingController();
    return Column(
      children: [
        TextField(
          controller: editingName,
        ),
        TextField(
          controller: editingEmoji,
        ),
        ElevatedButton(
          onPressed: () => onPressed(
            context,
            emoji: editingEmoji.text,
            name: editingName.text,
          ),
          child: const Text("Insert"),
        )
      ],
    );
  }

  Future<void> onPressed(
    BuildContext context, {
    required String name,
    required String emoji,
  }) =>
      addActivity(name: name, emoji: emoji).match<void>(
        (left) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error while adding new activity: $left"),
            ),
          );
        },
        (right) {
          print(right);
        },
      ).run(getIt.get());
}
