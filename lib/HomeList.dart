import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import 'list_bloc.dart';
import 'list_event.dart';
import 'list_modal.dart';
import 'list_state.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  bool ver = false;
  final bloc = ListBloc();

  @override
  Widget build(BuildContext context) {
    print('teste');
    return BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, ListState state) {
          return Scaffold(
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 6.0,
                child: Container(
                  height: 64,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                  highlightElevation: 8.0,
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                  onPressed: () {
                    _settingModalBottomSheet(context, state.list);
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: state.list.length <= 0
                        ? Center(
                            child: Text(
                                'Adicione novas taferas ao clicar no icone a baixo!!!!'))
                        : ReorderableList(
                            onReorder: (a, b) => false,
                            child: ListView.builder(
                                itemCount: state.list?.length ?? 0,
                                itemBuilder: (context, index) {
                                  print(state.list[index]);
                                  int num = Random().nextInt(1000);
                                  return
                                    Dismissible(
                                    child: CheckboxListTile(
                                        title: Text(
                                          state.list[index].frases,
                                          style: TextStyle(
                                              color: state.list[index].check
                                                  ? Colors.grey
                                                  : Colors.black87,
                                              decoration: state.list[index].check
                                                  ? TextDecoration.lineThrough
                                                  : null),
                                        ),
                                        value: state.list[index].check,
                                        onChanged: (value) => _checkChange(
                                            list: state.list,
                                            index: index,
                                            item: state.list[index])),
                                    background: Container(
                                        color: Colors.red,
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 25),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(Icons.delete),
                                            ))),
                                    key: ValueKey(num),
                                    onDismissed: (__) {
                                      _delete(index, state.list);
                                    },
                                  );
                                }),
                          ),
                  ),
                ],
              ));
        });
  }

  void addList(String currentFrase, List listCurrent) {
    bloc.dispatch(Increment(itemList: ItemList(frases: currentFrase), list: listCurrent));
  }

  void _checkChange({item, index, list}) {
    bloc.dispatch(Check(item: item, index: index, list: list));
  }

  void _delete(index, list) {
    bloc.dispatch(Delete(list: list, index: index));
  }

  void _settingModalBottomSheet(context, list) {
    final controller = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: new Container(
              height: 80.0,
              alignment: Alignment.bottomCenter,
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(fontSize: 15),
                      controller: controller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                addList(controller.text, list);
                                Navigator.pop(context);
                              }),
                          labelText: 'Adicione suas ações aqui',
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 1))),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
