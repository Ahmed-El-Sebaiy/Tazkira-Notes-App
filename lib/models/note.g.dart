// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      content: fields[0] as String,
      prefixIconCodePoint: fields[1] as int,
      prefixIconFontFamily: fields[2] as String?,
      suffixIconCodePoint: fields[3] as int,
      suffixIconFontFamily: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.prefixIconCodePoint)
      ..writeByte(2)
      ..write(obj.prefixIconFontFamily)
      ..writeByte(3)
      ..write(obj.suffixIconCodePoint)
      ..writeByte(4)
      ..write(obj.suffixIconFontFamily);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
