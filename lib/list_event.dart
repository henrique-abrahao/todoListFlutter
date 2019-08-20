import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'list_modal.dart';

abstract class ListEvent extends Equatable {
  ListEvent([List props = const []]) : super(props);
}

class Increment extends ListEvent {
  final List list;
  final ItemList itemList;


  Increment( {@required this.itemList, this.list = const []} );
}

class Check extends ListEvent {
  ItemList item;
  int index;
  List list;

  Check({this.item, this.index, this.list = const []});
}

class Delete extends ListEvent{
  List list;
  int index;

  Delete({this.list, this.index});
}
