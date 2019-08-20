import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'list_modal.dart';

@immutable
class ListState extends Equatable{
  final String frases;
  final List<ItemList> list;

  ListState({this.frases = '', this.list = const []}) : super([frases, list]);
}