import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyState {
  final String languageCode;
  final ThemeMode themeMode;

  MyState({required this.languageCode, required this.themeMode});

  MyState copyWith({String? languageCode, ThemeMode? themeMode}) {
    return MyState(
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class MyCubit extends Cubit<MyState> {
  MyCubit() : super(MyState(languageCode: "en", themeMode: ThemeMode.light));

  void changeLanguage(String lang) {
    emit(state.copyWith(languageCode: lang));
  }

  void changeTheme(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }
}
