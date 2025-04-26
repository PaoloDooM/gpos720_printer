///An enum to indicate the desired alignment for the command to be printed.
enum AlignmentTypes { left, center, right }

extension AlignmentTypesExtension on AlignmentTypes {
  String get label {
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
