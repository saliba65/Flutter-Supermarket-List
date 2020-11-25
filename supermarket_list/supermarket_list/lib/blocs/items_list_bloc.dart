import 'dart:async';

import 'package:supermarket_list/models/Item.dart';
import 'package:supermarket_list/pages/items.dart';


class ItemsListBloc {
  ItemsListBloc() {
    getList();
  }

  ModelItem itemBo = ModelItem();

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  ItemsListOrderBy orderBy = ItemsListOrderBy.alphaASC;

  ItemsListFilterBy filterBy = ItemsListFilterBy.all;

  reorder() {
    orderBy = (orderBy == ItemsListOrderBy.alphaASC) ? ItemsListOrderBy.alphaDESC : ItemsListOrderBy.alphaASC;
    getList();
  }

  toggleFilter(ItemsListFilterBy newVal) {
    filterBy = (filterBy == newVal) ? ItemsListFilterBy.all : newVal;
    getList();
  }

  getList() async {
    _controller.sink.add(await itemBo.itemsByList(ItemsPage.pkList, orderBy, filterBy));
  }

  dispose() {
    _controller.close();
  }
}
