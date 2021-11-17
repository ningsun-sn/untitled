import 'dart:math';
import 'dart:ui';

mixin ColorUtils {

  static const Color blue = Color(0xff212121);
  static const Color primaryText = Color(0xff212121);
  static const Color blackText = Color(0xff333333);
  static const Color grayText = Color(0xff999999);
  static const Color grayBackground = Color(0xffEDEDED);
  static const Color grayDeepBackground = Color(0xffDEDEDE);
  static const Color dividerColor = Color(0xffBDBDBD);
  static const Color transparentGaryColor = Color(0xFF333333);

  //  static Color gradientColor(){
//    return ColorTween(
//       begin:Colors.blue,
//       end: Colors.blueAccent,
//     ).animate(new CurvedAnimation(parent: AnimationController(), curve: Interval(0, 1))).value;
//  }

  static getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }

  /// 背景颜色
  static Color bgColor1 = Color(0xFFFAF8EF);
  static Color bgColor2 = Color(0xFFBBAD9F);
  static Color bgColor3 = Color(0xFF8F7B65);

  /// 文字颜色
  static Color textColor1 = Color(0xFF766E65);
  static Color textColor2 = Color(0xFFF8F6F2);
  static Color textColor3 = Color(0xFFFFFFFF);


  /// 数字的背景色
  static Color gc0 = Color(0xFFCCC1B4);  /// 不展示数字
  static Color gc2 = Color(0xFFEDE4DA);
  static Color gc4 = Color(0xFFEEE0CA);
  static Color gc8 = Color(0xFFF3B279);
  static Color gc16 = Color(0xFFF69564);
  static Color gc32 = Color(0xFFF77C5F);
  static Color gc64 = Color(0xFFF75F3C);
  static Color gc128 = Color(0xFFEDD073);
  static Color gc256 = Color(0xFFEECB62);
  static Color gc512 = Color(0xFFEDC850);
  static Color gc1024 = Color(0xFFEDC850);
  static Color gc2048 = Color(0xFFEDC850);
  static Color mapValueToColor(int value) {
    switch(value){
      case 0:
        return gc0;
      case 2:
        return gc2;
      case 4:
        return gc4;
      case 8:
        return gc8;
      case 16:
        return gc16;
      case 32:
        return gc32;
      case 64:
        return gc64;
      case 128:
        return gc128;
      case 256:
        return gc256;
      case 512:
        return gc512;
      case 1024:
        return gc1024;
      case 2048:
        return gc2048;
      default:
        return gc2048;
    }
  }
}