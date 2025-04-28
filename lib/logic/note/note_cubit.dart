import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tazkira/models/note.dart';

 part 'note_state.dart';

class NoteCubit extends Cubit<NoteStates> {
  NoteCubit() : super(NoteInitialState());

  final Box<NoteModel> notesBox = Hive.box<NoteModel>('notesBox');

  void getNotes() async {
    try {
      final notes = notesBox.values.toList();
      emit(NoteSuccessState(notes));
    } catch (e) {
      emit(NoteErrorState('Failed to load notes: $e'));
    }
  }

  void addNote(String content) async {
    try {
      final note = NoteModel(
        content: content,
        prefixIconCodePoint: FontAwesomeIcons.circle.codePoint,
        prefixIconFontFamily: FontAwesomeIcons.circle.fontFamily,
        suffixIconCodePoint: FontAwesomeIcons.star.codePoint,
        suffixIconFontFamily: FontAwesomeIcons.star.fontFamily,
      );
      await notesBox.add(note);
      final updatedNotes = notesBox.values.toList();
      emit(NoteSuccessState(updatedNotes));
    } catch (e) {
      emit(NoteErrorState('Failed to add note: $e'));
    }
  }

  void deleteNote(int index) async {
    try {
      await notesBox.deleteAt(index);
      getNotes();
    } catch (e) {
      emit(NoteErrorState('Failed to delete note: $e'));
    }
  }

  void togglePrefixIcon(int index) async {
    try {
      final note = notesBox.getAt(index);
      if (note != null) {
        print('Current Prefix Icon CodePoint: ${note.prefixIconCodePoint}, FontFamily: ${note.prefixIconFontFamily}');
        final updatedNote = NoteModel(
          content: note.content,
          prefixIconCodePoint: note.prefixIconCodePoint == FontAwesomeIcons.circle.codePoint
              ? FontAwesomeIcons.circleCheck.codePoint
              : FontAwesomeIcons.circle.codePoint,
          prefixIconFontFamily: note.prefixIconFontFamily,
          suffixIconCodePoint: note.suffixIconCodePoint,
          suffixIconFontFamily: note.suffixIconFontFamily,
        );
        print('Updated Prefix Icon CodePoint: ${note.prefixIconCodePoint}, FontFamily: ${note.prefixIconFontFamily}');
        await notesBox.putAt(index, updatedNote);
        //final updatedNotes = notesBox.values.toList();
        emit(NoteSuccessState(notesBox.values.toList()));
      }
    } catch (e) {
      emit(NoteErrorState('Failed to toggle prefix icon: $e'));
    }
  }

  void toggleSuffixIcon(int index) async {
    try {
      final note = notesBox.getAt(index);
      if (note != null) {
        print('Current Suffix Icon CodePoint: ${note.suffixIconCodePoint}, FontFamily: ${note.suffixIconFontFamily}');
        final updatedNote = NoteModel(
          content: note.content,
          prefixIconCodePoint: note.prefixIconCodePoint,
          prefixIconFontFamily: note.prefixIconFontFamily,
          suffixIconCodePoint: note.suffixIconCodePoint == FontAwesomeIcons.star.codePoint
              ? FontAwesomeIcons.solidStar.codePoint
              : FontAwesomeIcons.star.codePoint,
          suffixIconFontFamily: note.suffixIconFontFamily,
        );
        print('Updated Suffix Icon CodePoint: ${note.suffixIconCodePoint}, FontFamily: ${note.suffixIconFontFamily}');
        await notesBox.putAt(index, updatedNote);
        //final updatedNotes = notesBox.values.toList();
        emit(NoteSuccessState(notesBox.values.toList()));
      }
    } catch (e) {
      emit(NoteErrorState('Failed to toggle suffix icon: $e'));
    }
  }
}
