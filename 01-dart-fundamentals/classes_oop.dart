// Base class
class Animal {
  final String name;
  Animal(this.name); // shorthand constructor syntax - assigns directly to the field

  void makeSound() {
    print('$name makes a generic sound');
  }
}

// Inheritance with `extends` - Dog IS-A Animal
class Dog extends Animal {
  Dog(String name) : super(name); // must call the parent constructor

  @override
  void makeSound() {
    print('$name barks');
  }
}

// Mixins: reusable behavior that doesn't fit a strict inheritance hierarchy -
// "can-do" rather than "is-a". A class CAN use multiple mixins, unlike
// single inheritance with `extends`.
mixin Swimmer {
  void swim() => print('Swimming!');
}

class Fish extends Animal with Swimmer {
  Fish(String name) : super(name);

  @override
  void makeSound() => print('$name blubs quietly');
}

void main() {
  final dog = Dog('Rex');
  dog.makeSound();

  final fish = Fish('Nemo');
  fish.makeSound();
  fish.swim(); // available because of the mixin, not inheritance

  // Polymorphism: a List<Animal> can hold ANY subtype, and calling
  // makeSound() invokes each subtype's OWN overridden version.
  List<Animal> animals = [Dog('Buddy'), Fish('Dory')];
  for (final animal in animals) {
    animal.makeSound();
  }
}
