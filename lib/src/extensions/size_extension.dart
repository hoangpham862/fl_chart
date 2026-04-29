import 'dart:ui';

extension SizeExtension on Size {
  Size rotateByQuarterTurns(int quarterTurns) {
    if (quarterTurns < 0) {
      throw ArgumentError('quarterTurns must be greater than or equal to 0.');
    }
    switch (quarterTurns % 4) {
      case 0:
      case 2:
        return this;
      default:
        return Size(height, width);
    }
  }
}
