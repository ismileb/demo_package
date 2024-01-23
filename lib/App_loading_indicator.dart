

import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const AppLoadingIndicator({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isLoading) {
      widgetList.add(
        const Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.grey),
        ),
      );
      widgetList.add(const Center(child: CircularProgressIndicator(color: Colors.amber,)));
    }
    return Stack(
      children: widgetList,
    );
  }
}
