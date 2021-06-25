import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_cover_image.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_cover_sub_title.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_cover_swipe_up.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_cover_text.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_cover_title.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_top_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InfoCardViewCover extends AnimatedWidget {
  final maxHeight;

  final controller;

  InfoCardViewCover(
      {Key? key,
      required AnimationController this.controller,
      required double this.maxHeight})
      : super(key: key, listenable: controller);

  Animation<double> get _controllerValue => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    return Container(
        color: Colors.white,
        height: service.controller
            .calculateAnimation(maxHeight, _controllerValue.value, 17.5.h),
        padding: EdgeInsets.only(
            left: 2.9.h, top: 1.9.h, right: 1.9.h, bottom: 1.9.h),
        child: GestureDetector(
            onVerticalDragStart: (dragDetails) =>
                service.controller.setStartVerticalDragDetails(dragDetails),
            onVerticalDragUpdate: (dragDetails) =>
                service.controller.setUpdateVerticalDragDetails(dragDetails),
            onVerticalDragEnd: (endDetails) =>
                service.controller.onVerticalDragEnd(endDetails, controller),
            child: Container(
                child: GestureDetector(
                    onTap: () =>
                        controller.value == 1 ? controller.animateTo(0) : null,
                    child: Stack(fit: StackFit.expand, children: [
                      InfoCardViewTopHeader(_controllerValue),
                      InforCardViewCoverImage(_controllerValue),
                      InforCardViewCoverSubTitle(_controllerValue),
                      InforCardViewCoverTitle(_controllerValue),
                      InforCardViewCoverText(_controllerValue),
                      InforCardViewCoverSwipeUp(_controllerValue)
                    ])))));
  }
}