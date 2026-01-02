# aug_validateform

**Zero-Boilerplate, Reactive Validation Suite for Flutter**

Welcome to the `aug_validateform` repository. This project provides a robust, professional-grade solution for handling form validation in Flutter applications using Dart's code generation capabilities.

---

## Repository Structure

This is a monorepo containing:

- **[aug_validateform](packages/aug_validateform)**: The core package containing validation annotations and the `ValidationWatcher` widget.
- **[aug_validateform_generator](packages/aug_validateform_generator)**: The code generator package that builds the reactive validation mixins.
- **[example](example)**: A complete demo application showcasing real-time validation in macOS and Web environments.

---

## Quick Start

1. Add both `aug_validateform` (as a dependency) and `aug_validateform_generator` (as a dev_dependency) to your project.
2. Annotate your models with `@Validatable()` and field rules like `@Email()` or `@MinLength()`.
3. Run `dart run build_runner build` to generate your validation mixins.

For detailed usage, visit the [Core Package README](packages/aug_validateform/README.md).

---

## Author & Contact

This project is developed by **Muhammad Omar**.

- **LinkedIn**: [muhammad-omar-0335](https://www.linkedin.com/in/muhammad-omar-0335/)
- **GitHub**: [umarKhan1](https://github.com/umarKhan1)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
