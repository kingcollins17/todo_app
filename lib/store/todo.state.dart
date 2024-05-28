
import 'package:flutter/material.dart';

class TodoState {

    TodoState();

    factory TodoState.initial() => TodoState();

    @override
    bool operator ==(other) =>
        identical(this, other) ||
        other is TodoState &&
            runtimeType == other.runtimeType;

    @override
    int get hashCode =>
        super.hashCode;

    @override
    String toString() {
    return "TodoState { }";
    }
}
	