class Details{
  final String image;

  Details({required this.image});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      image: json['avatar'],
     // age: json['employee_age'],
    );
  }
}