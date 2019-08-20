import 'package:test/test.dart';
import 'package:todo/list_bloc.dart';
import 'package:todo/list_event.dart';
import 'package:todo/list_modal.dart';

import 'package:todo/list_state.dart';

void main() {
  group('ListBloc', () {
    ListBloc listBloc;

    setUp(() {
      listBloc = ListBloc();
    });

    test('initial state is []', () {
      expect(listBloc.initialState, ListState());
    });

    test('add Elements', () {
      final List<ListState> expected = [
        ListState(),
        ListState(list: [ItemList(frases: 'teste', check: false)])
      ];

      expectLater(listBloc.state, emitsInOrder(expected));

      listBloc.dispatch(Increment(itemList: ItemList(frases: 'teste')));
    });

    test('check Elements', () {
      final item = ItemList(frases: 'teste', check: false);

      final List<ListState> expected = [
        ListState(),
        ListState(list: [item]),
        ListState(list: [ItemList(frases: 'teste', check: true)])
      ];
      expectLater(listBloc.state, emitsInOrder(expected));

      listBloc.dispatch(Increment(itemList: item));

      listBloc.dispatch(Check(index: 0, item: item, list: [item]));
    });

    test('Delete Elements', (){
      final item = ItemList(frases: 'teste', check: false);
      final List<ListState> expected = [
        ListState(),
        ListState(list: [item]),
        ListState(list: []),
      ];
      expectLater(listBloc.state, emitsInOrder(expected));

      listBloc.dispatch(Increment(itemList: item));
      listBloc.dispatch(Delete(list: [item], index: 0));
    });
  });
}
