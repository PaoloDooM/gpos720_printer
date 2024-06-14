enum AlignmentTypes { left, center, right }

extension AlignmentTypesExtension on AlignmentTypes {
  String get getLabel {
    switch (this) {
      case AlignmentTypes.left:
        return "LEFT";
      case AlignmentTypes.center:
        return "CENTER";
      case AlignmentTypes.right:
        return "RIGHT";
      default:
        throw UnimplementedError("Not implemented.");
    }
  }
}
