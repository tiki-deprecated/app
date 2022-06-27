# Contributing with TIKI

Thanks for contributing with Tiki!

The following is a set of guidelines for contributing to TIKI and its packages, which are hosted in the [TIKI Organization](https://github.com/tiki) on GitHub. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

### Asking questions

Please don't use the repositories issues to ask/answer questions. We have a direct channel with our users through [Tiki's Public Discord](https://discord.com/invite/evjYQq48Be).  You are welcome to join our server and ask all your questions there!

### Reporting Bugs
To report a bug, please [file an issue](https://github.com/tiki/app/issues/new) containing the following information:
**Device model and OS version**: [Check in iOS](https://support.apple.com/en-us/HT201685) / [Check in Android](https://support.google.com/android/answer/7680439?hl=en)
**App version:**  It can be found in Appstore/Playstore or in the end of the app's user modal.
**Description:** The description of the error. What did not happen that should and/or what happened that shouldn't.
**Steps to Reproduce:** Detailed steps to reproduce the bug.
**Expected Result:**  What should be the expected behavior without the bug.

### Suggesting Enhancements
Before opening an issue with enhancements suggestions, please discuss it with us in [Tiki's Public Discord](https://discord.com/invite/evjYQq48Be).

### Contribute with code
To contribute with code you should follow these steps:
1. Fork the repository.
2. Create a branch out of develop. If it is related to a issue from the original repository, start the branch name with the # symbol followed by the issue number.
3. Write the code, commit and merge into your develop branch and make sure it builds, all the warnings are resolved and all tests passes.
4. Create a Pull Request from your branch to the original repository, describing which changes your code did.
5. Wait for code review and apply any requested changes.

### Test guidelines
We encourage you to write automated tests to all the code you write, but it is just required to have automated tests for publicly available APIs.

Before creating a Pull Request you should write at least one test case that describes what the code do and how to test it.

Sometimes the code have too much third party integrations that makes it hard to add automated tests. If that's the case don't bother mocking up code. Use a manual test scenario and add a screencapture of it.

Refer to [Flutter Integration Tests Documentation](https://docs.flutter.dev/testing/integration-tests) for writing integration tests.

### Documentation guidelines
In TIKI we believe that the code should be self explanatory for any tech reader.

Avoid using comments to explain what you are doing. If one can't understand reading the code, it should be rewritten.

But in an open source project, one should not need to read all the code to understand which public APIs to use. That's where we need in-code documentation.

You don't need to document all and every line of code, class, top level methods and properties. If you want, that's ok, but not required.

It is required to document all and every publicly available APIs that will be used by others to interact with the code.

To document the code follow [Dart Documentation Guidelines](https://dart.dev/guides/language/effective-dart/documentation#doc-comments).

### Styleguides
- Name all the files, classes, methods, functions and variables in english with a self-explanatory name.
- For filenames use snake_case.
- For classes use PascalCase.
- For variables and functions use camelCase.
- Use one file for each class. The filename should be the class name.
- Groups files first by what feature they implement, using the slice architecture. Inside each slice, group the files by role.
- Avoid creating a folder if it will hold just one or two files.
- Use local imports always when possible.
- For Flutter code use [flutter_lints](https://pub.dev/packages/flutter_lints)
