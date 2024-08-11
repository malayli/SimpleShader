# Contributing

## Found a bug or have a suggestion?
If you find a bug in the source code or you have a suggestion for an improvement or new feature, please submit an issue to discuss with the team before working on your PR.

## Submit an Issue
Please fill the following information in each (bug) issue you submit:
  
* Title: Use a clear and descriptive title for the issue to identify the problem
* Description: Description of the issue
* Steps to Reproduce: numbered step by step. (1,2,3.… and so on)
* Expected behaviour: What you expect to happen
* Actual behaviour: What actually happens
* Version: The version of the library
* Repository: Link to the repository you are working with
* Operating system: The operating system used
* Additional information: Any additional to help to reproduce. (screenshots, animated gifs)

## Branch naming convention

### Feature Branches
These branches are used for developing new features. Use the prefix `feature/`.
For example: feature/login-system

### Bugfix Branches
These branches are used to fix bugs in the code. Use the prefix `bugfix/`.
For example: bugfix/header-styling

### Hotfix Branches
These branches are made directly from the production branch to fix critical bugs in the production environment. Use the prefix `hotfix/`.
For example: hotfix/critical-security-issue

### Release Branches
These branches are used to prepare for a new production release. Use the prefix `release/`.
For example: release/1.0.1

### Documentation Branches
These branches are used to write, update, or fix documentation. Use the prefix `docs/`.
For example: docs/api-endpoints

## Pull Requests
1. Fork the [repo](https://github.com/malayli/SimpleShader.git)

2. Create a branch and implement your feature/bugfix & add test cases

3. The PR title (and commit title) must start with these following prefixes:
- `feat`: (new feature for the user, not a new feature for build script)
- `fix`: (bug fix for the user, not a fix to a build script)
- `docs`: (changes to the documentation)
- `style`: (formatting, missing semi colons, etc; no production code change)
- `refactor`: (refactoring production code, eg. renaming a variable)
- `test`: (adding missing tests, refactoring tests; no production code change)
- `chore`: (updating grunt tasks etc; no production code change)

Example:
```
feat: add hat wobble
^--^  ^------------^
|     |
|     +-> Summary in present tense.
|
+-------> Type: chore, docs, feat, fix, refactor, style, or test.
```

4. Ensure test cases & static analysis runs succesfully

5. Submit a pull request to `develop` branch
  
Please include unit tests where necessary to cover any functionality that is introduced.
  
## Coding Guidelines
* All features or bug fixes **must be tested** by one or more unit tests/specs.
* All API methods **must be documented** in a standard format and potentially in the user guide.
* All code must follow the style of the existing code.
* Remove the default Xcode header in each source file you created:
```
//
//  SourceFile.swift
//  AppName
//
//  Created by John Doe on 14/05/2024.
//
```
