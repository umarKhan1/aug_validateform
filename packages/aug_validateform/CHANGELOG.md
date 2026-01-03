# Changelog

## 0.0.1-dev.6

- Fixed analysis error in the generator's example project by providing a mock `ValueNotifier` for pure Dart environments.

## 0.0.1-dev.5

- Internal refactoring: moved core annotations to `aug_validateform_annotations` for better code generation performance and pure Dart analysis.
- Re-exports everything from `aug_validateform_annotations`.
- Relocated example project for improved pub.dev analysis.

## 0.0.1-dev.4

- Improve documentation by adding dartdoc comments to all annotations.
- Fix mono-repo naming conflict in root pubspec.
- Include package example by moving it into the package directory.
- Use absolute GitHub raw link for GIF visibility on pub.dev.

## 0.0.1-dev.3

- Fix GIF visibility on pub.dev.

## 0.0.1-dev.1

- Initial release of `aug_validateform`.
- Support for zero-boilerplate reactive validation using Dart Augmentations.
- Comprehensive suite of built-in validators (@Required, @Email, @Phone, etc.).
- Wasm and Impeller ready.
