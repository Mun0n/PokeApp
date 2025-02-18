# Flutter Clean Architecture Demo

A learning project to demonstrate Flutter development with AI assistance, focusing on best practices and modern architecture.

## Project Overview

- **Purpose**: Educational demo showcasing Flutter development with AI pair programming
- **API**: Using [PokéAPI](https://pokeapi.co/) as data source
- **Architecture**: Clean Architecture with SOLID principles
- **Development Approach**: Test-Driven Development (TDD)

## Technical Stack

- Flutter/Dart
- Clean Architecture (3 layers):
  - Domain (Business Logic)
  - Data (Repository Implementation)
  - Presentation (UI/UX)
- Testing:
  - Unit Tests
  - Widget Tests
  - Integration Tests

## Development Guidelines

1. All features must follow Clean Architecture principles
2. New features require discussion before implementation
3. TDD approach: tests first, implementation second
4. SOLID principles must be respected:
   - Single Responsibility
   - Open-Closed
   - Liskov Substitution
   - Interface Segregation
   - Dependency Inversion

## Project Structure

```
lib/
├── core/          # Shared core functionality
├── features/      # Feature modules
│   └── auth/      # Authentication feature
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
