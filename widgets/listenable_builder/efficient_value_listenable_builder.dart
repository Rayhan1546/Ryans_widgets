import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EfficientValueListenableBuilder<T> extends StatefulWidget {
  final ValueListenable<T> valueListenable;
  final Widget Function(BuildContext, T, Widget?) builder;
  final dynamic Function(T value)? buildFor;

  const EfficientValueListenableBuilder({
    Key? key,
    required this.valueListenable,
    required this.builder,
    this.buildFor,
  }) : super(key: key);

  @override
  EfficientValueListenableBuilderState<T> createState() =>
      EfficientValueListenableBuilderState<T>();
}

class EfficientValueListenableBuilderState<T> extends State<EfficientValueListenableBuilder<T>> {
  late T previousValue;
  dynamic previousSpecificValue;

  @override
  void initState() {
    super.initState();
    previousValue = widget.valueListenable.value;
    if (widget.buildFor != null) {
      previousSpecificValue = widget.buildFor!(previousValue);
    }
    widget.valueListenable.addListener(_onValueChanged);
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_onValueChanged);
    super.dispose();
  }

  void _onValueChanged() {
    final currentValue = widget.valueListenable.value;

    if (widget.buildFor != null) {
      final currentSpecificValue = widget.buildFor!(currentValue);
      if (previousSpecificValue != currentSpecificValue) {
        setState(() {
          previousValue = currentValue;
          previousSpecificValue = currentSpecificValue;
        });
      } else {
        previousValue = currentValue;
        previousSpecificValue = currentSpecificValue;
      }
    } else if (previousValue != currentValue) {
      setState(() {
        previousValue = currentValue;
      });
    } else {
      previousValue = currentValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.valueListenable.value, null);
  }
}
