import 'package:flutter/cupertino.dart';

class Dimension{
  static const regularPadding = 16.0;
  static const minimalPadding = 8.0;
  static const heightPadding = 32.0;
  static const heightPaddingBigger = 56.0;

  EdgeInsets get minimalPaddingHorizontal => const EdgeInsets.symmetric(horizontal: minimalPadding);
  EdgeInsets get regularPaddingAll => const EdgeInsets.all(regularPadding);
  EdgeInsets get regularPaddingHorizontal => const EdgeInsets.symmetric(horizontal: regularPadding);


}