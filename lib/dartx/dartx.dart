import 'dart:core';

class DartX {

  final list = [0, 1, 2, 3, 4, 5];
  final numbers = [1, 2, 4, 9, 10, 11, 12, 15, 16, 19, 20, 21];

  final dogs = [
    Dog(name: 'Tom', age: 3),
    Dog(name: 'Charlie', age: 7),
    Dog(name: 'Bark', age: 1),
    Dog(name: 'Cookie', age: 4),
    Dog(name: 'Charlie', age: 2),
  ];

  final words = ['this', 'is', 'a', 'test'];

  final nestedList = [
    [1, 2, 3],
    [4, 5, 6]
  ];

}

class Dog {
  final String name;
  final int age;

  Dog({required this.name, required this.age});
}