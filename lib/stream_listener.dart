import 'package:flutter/material.dart';

class StreamListener<DataT> extends StatelessWidget {
  final Stream<DataT> _stream;
  final Widget Function(BuildContext context, DataT data) builder;
  const StreamListener(this._stream, {required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) =>
          switch ((snapshot.connectionState, snapshot.data)) {
        (ConnectionState.none, _) => const CircularProgressIndicator(),
        (ConnectionState.waiting, _) => const CircularProgressIndicator(),
        (ConnectionState.done, _) => const Text("Completed"),
        (ConnectionState.active, null) => const Text("Error: Missing data"),
        (ConnectionState.active, final state?) => builder(context, state),
      },
    );
  }
}
