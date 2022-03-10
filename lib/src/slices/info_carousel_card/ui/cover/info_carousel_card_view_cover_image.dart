/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/helper_image.dart';
import '../../info_carousel_card_service.dart';

class InfoCarouselCardViewCoverImage extends StatelessWidget {
  final Animation<double> _animationValue;

  const InfoCarouselCardViewCoverImage(this._animationValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    var model = service.model.cover!.image!;
    return HelperImage(model,
        width: service.controller.calculateAnimation(
            MediaQuery.of(context).size.width, _animationValue.value, 18.h));
  }
}
