import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ItemList extends Equatable {
  bool check;
  String key;
  String frases;

  ItemList({this.check = false, this.frases = '', String key})
      : this.key = Uuid().v1(),
        super([frases, check]);
}
