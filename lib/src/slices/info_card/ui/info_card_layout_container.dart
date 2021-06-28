import 'package:app/src/slices/info_card/ui/info_card_view_cover.dart';
import 'package:flutter/material.dart';

import 'info_card_view_content.dart';

class InfoCardLayoutContainer extends StatefulWidget {
  final BoxConstraints constraints;

  const InfoCardLayoutContainer(this.constraints);

  @override
  State<StatefulWidget> createState() => _InfoCardLayoutContainerState();
}

class _InfoCardLayoutContainerState extends State<InfoCardLayoutContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: widget.constraints.maxHeight,
        ),
        color: Colors.transparent,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: SingleChildScrollView(
                child: Column(
              children: [
                InfoCardViewCover(
                    maxHeight: widget.constraints.maxHeight,
                    controller: controller),
                InfoCardViewContent(widget.constraints, controller)
              ],
            ))));
  }
}
