part of 'note_cubit.dart';

abstract class NoteStates {}

class NoteInitialState extends NoteStates {}

class ToggleIconState extends NoteStates {
  final IconData prefixIcon;
  final IconData suffixIcon;

  ToggleIconState({required this.prefixIcon, required this.suffixIcon});
}

class NoteLoadingState extends NoteStates {}
class NoteSuccessState extends NoteStates {
  final List<NoteModel> notes;
  NoteSuccessState(this.notes);
}
class NoteErrorState extends NoteStates {
  final String message;
  NoteErrorState(this.message);
}