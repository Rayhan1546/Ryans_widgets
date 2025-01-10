# EfficientValueListenableBuilder

A custom Flutter widget that efficiently rebuilds only when specified values change in a ValueListenable. This widget extends the functionality of Flutter's built-in ValueListenableBuilder by allowing you to control when rebuilds occur.

## Features

- 🚀 Efficient rebuilding based on specific value changes
- 🔄 Support for both full model and specific property watching
- 💡 Easy to use API similar to ValueListenableBuilder
- 🎯 Reduces unnecessary rebuilds


## Basic Usage
When working with models, you can watch specific properties for changes:

```bash
class UserModel {
  final String name;
  final int age;
  final String email;

  UserModel({
    required this.name,
    required this.age,
    required this.email,
  });
}

final userNotifier = ValueNotifier(
  UserModel(
    name: 'John',
    age: 25,
    email: 'john@example.com',
  ),
);

// This will only rebuild when age changes
EfficientValueListenableBuilder<UserModel>(
  valueListenable: userNotifier,
  buildForValue: (value) => value.age,  // Only watch the age property
  builder: (context, user, _) {
    return Text('Age: ${user.age}');
  },
);
```