import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tazkira/logic/note/note_cubit.dart';
import 'package:tazkira/models/note.dart';
//import 'package:tazkira/models/note.dart';
import 'package:tazkira/widgets/main_segmented_button.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocBuilder<NoteCubit, NoteStates>(
            builder: (context, state) {
              print('Current state is : $state');
              final notes = state is NoteSuccessState ? state.notes : [];

              if (state is NoteInitialState) {
                context.read<NoteCubit>().getNotes();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  mainSegmentedButton(context),
                  SizedBox(height: 50),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Start typing...',
                      hintStyle: TextStyle(color: Color(0xFF4AA079)),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.circle, color: Colors.amberAccent),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.star, color: Colors.amberAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Color(0xFF4AA079)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Color(0xFF4AA079)),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        print('submitting note: $value');
                        context.read<NoteCubit>().addNote(value);
                        controller.clear();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return noteItem(
                          note: note,
                          index: index,
                          context: context,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(thickness: 1.5),
                      itemCount: notes.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget noteItem({
    required NoteModel note,
    required int index,
    required BuildContext context,
  }){
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: Color(0xff370617),
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            FontAwesomeIcons.trashCan,
            color: Colors.white,
            size: 30,
          ),
        ),
        child: TextField(
          controller: TextEditingController(text: note.content),
          maxLines: null,
          cursorColor: Color(0xFF4AA079),
          decoration: InputDecoration(
            hintText: 'Start typing...',
            hintStyle: TextStyle(color: Color(0xFF4AA079)),
            prefixIcon: IconButton(
              onPressed: () {
                context.read<NoteCubit>().togglePrefixIcon(index);
              },
              icon: Icon(FontAwesomeIcons.circleCheck, color: Colors.amberAccent),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<NoteCubit>().toggleSuffixIcon(index);
              },
              icon: Icon(FontAwesomeIcons.solidStar, color: Colors.amberAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xFF4AA079)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xFF4AA079)),
            ),
          ),
        ),
        onDismissed: (direction) {
          context.read<NoteCubit>().deleteNote(index);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note Deleted')));
        },
      );
  }
}