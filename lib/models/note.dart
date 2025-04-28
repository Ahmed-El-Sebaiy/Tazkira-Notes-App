import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';  // This is the part file where the adapter will be generated

@HiveType(typeId: 0)  // Define a unique ID for this type
class NoteModel extends HiveObject {
  @HiveField(0)
  final String content;
  
  @HiveField(1)
  final int prefixIconCodePoint;

  @HiveField(2)
  final String? prefixIconFontFamily;

  @HiveField(3)
  final int suffixIconCodePoint;

  @HiveField(4)
  final String? suffixIconFontFamily;


  NoteModel({
    required this.content,
    required this.prefixIconCodePoint,
    required this.prefixIconFontFamily,
    required this.suffixIconCodePoint,
    required this.suffixIconFontFamily,
  });

  IconData get prefixIcon {
    if (prefixIconCodePoint == 0) {
      print('Invalid prefixIconCodePoint: $prefixIconCodePoint');
      return FontAwesomeIcons.question; // Fallback icon
    }
    return IconData(
      prefixIconCodePoint,
      fontFamily: prefixIconFontFamily ?? 'FontAwesomeRegular',
    );
  }

  IconData get suffixIcon {
    if (suffixIconCodePoint == 0) {
      print('Invalid suffixIconCodePoint: $suffixIconCodePoint');
      return FontAwesomeIcons.question; // Fallback icon
    }
    return IconData(
      suffixIconCodePoint,
      fontFamily: suffixIconFontFamily ?? 'FontAwesomeRegular',
    );
  }
}
