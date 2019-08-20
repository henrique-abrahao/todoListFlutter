import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'list_event.dart';
import 'list_modal.dart';
import 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  @override
  ListState get initialState => ListState();

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is Increment) {
      List list = List.from(event.list);

      ItemList itemList = ItemList(frases: event.itemList.frases);

      list.add(itemList);

      yield ListState(list: List.from(list));
    } else if (event is Check) {
      final item =
          ItemList(frases: event.item.frases, check: !event.item.check);

      final newList = List.from(event.list);
      newList[event.index] = item;

      yield ListState(list: List.from(newList));
    } else if (event is Delete) {
      List list = List.from(event.list);

      list.removeAt(event.index);

      yield ListState(list: List.from(list));
    }
  }
}
