class User {
  final int id;
  final String name;
  final String job;
  final String email;
  final String phone;

  const User({
    required this.id,
    required this.name,
    required this.job,
    required this.email,
    required this.phone,
  });

  User copyWith({
    int? id,
    String? name,
    String? job,
    String? email,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

final List<User> sampleUsers = [
  const User(
    id: 1,
    name: 'Станіслав Гончаренко',
    job: 'Developer',
    email: 'stanislav@example.com',
    phone: '+380986512345',
  ),
  const User(
    id: 2,
    name: 'Олена Петренко',
    job: 'Developer',
    email: 'olena@example.com',
    phone: '+380986512346',
  ),
  const User(
    id: 3,
    name: 'Андрій Коваленко',
    job: 'Developer',
    email: 'andriy@example.com',
    phone: '+380986512347',
  ),
  const User(
    id: 4,
    name: 'Марія Шевченко',
    job: 'Developer',
    email: 'maria@example.com',
    phone: '+380986512348',
  ),
];
