import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/emoji.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/home/emoji_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InsertActivityForm extends HookWidget {
  const InsertActivityForm({super.key});

  @override
  Widget build(BuildContext context) {
    final editingName = useTextEditingController();
    final editingEmoji = useState(Emoji.dart);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: editingName,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: Emoji.values
              .map(
                (emoji) => EmojiButton(
                  selected: editingEmoji.value,
                  emoji: emoji,
                  onPressed: (emoji) => editingEmoji.value = emoji,
                ),
              )
              .toList(),
        ),
        ElevatedButton(
          onPressed: () => onPressed(
            context,
            emoji: editingEmoji.value,
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
    required Emoji emoji,
  }) =>
      addActivity(name: name, emoji: emoji).match<void>(
        (apiError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error while adding new activity: $apiError"),
            ),
          );
        },
        (id) {
          print(id);
        },
      ).run(getIt.get());
}
