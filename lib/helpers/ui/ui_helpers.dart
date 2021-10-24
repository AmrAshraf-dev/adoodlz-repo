import 'package:flutter/material.dart';

/// Contains useful functions to reduce boilerplate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _verticalSpaceSmall = 8.0;
  static const double _verticalSpaceMedium = 16.0;
  static const double _verticalSpaceLarge = 40.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _horizontalSpaceSmall = 8.0;
  static const double _horizontalSpaceMedium = 16.0;
  static const double _horizontalSpaceLarge = 40.0;

  /// Returns a vertical space with height set to [_VerticalSpaceSmall]
  static Widget verticalSpaceSmall() {
    return const SizedBox(
      height: _verticalSpaceSmall,
    );
  }

  /// Returns a vertical space with height set to [_VerticalSpaceMedium]
  static Widget verticalSpaceMedium() {
    return const SizedBox(
      height: _verticalSpaceMedium,
    );
  }

  /// Returns a vertical space with height set to [_VerticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return const SizedBox(
      height: _verticalSpaceLarge,
    );
  }

  /// Returns a horizontal space with height set to [_HorizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return const SizedBox(
      width: _horizontalSpaceSmall,
    );
  }

  /// Returns a horizontal space with height set to [_HorizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return const SizedBox(
      width: _horizontalSpaceMedium,
    );
  }

  /// Returns a horizontal space with height set to [HorizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return const SizedBox(
      width: _horizontalSpaceLarge,
    );
  }
}
