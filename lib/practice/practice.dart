
class Student {
   String name;
   int age;
   Student({required this.name, required this.age});
}

List<Student> students = [
  Student(name: "Rakesh", age: 20),
  Student(name: "Ratnesh", age: 40),
  Student(name: "Mahesh", age: 16),
  Student(name: "Ganesh", age: 12),
];

List<Student> reduceStudents = [];
void main() {
  reduceStudents = students.where((e) => e.age >= 18 ).toList();
  print(reduceStudents.length);
}
