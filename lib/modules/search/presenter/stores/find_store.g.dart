// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FindStore on _FindStoreBase, Store {
  final _$stateAtom = Atom(name: '_FindStoreBase.state');

  @override
  FindState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(FindState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_FindStoreBaseActionController =
      ActionController(name: '_FindStoreBase');

  @override
  dynamic setState(FindState value) {
    final _$actionInfo = _$_FindStoreBaseActionController.startAction(
        name: '_FindStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_FindStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
