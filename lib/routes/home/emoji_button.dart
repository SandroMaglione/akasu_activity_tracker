import 'package:akasu_activity_tracker/emoji.dart';
import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final Emoji emoji;
  final Emoji selected;
  final void Function(Emoji emoji) onPressed;
  const EmojiButton({
    super.key,
    required this.emoji,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(emoji),
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(selected == emoji ? 3 : 0.5),
        textStyle: MaterialStatePropertyAll(
            Theme.of(context).textTheme.headlineMedium),
      ),
      child: Text(emoji.toString()),
    );
  }
}
