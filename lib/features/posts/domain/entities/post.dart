import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.body, required this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body];
}
