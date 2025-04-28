import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/theme_cubit.dart';

Widget mainSegmentedButton(BuildContext context){
  return BlocBuilder<ThemeCubit, ThemeStates>(
  builder: (context, state) {
    return SegmentedButton<ThemeStates>(
    segments: [
      ButtonSegment(
        value: ThemeLightState(),
        label: Icon(
          Icons.light_mode_outlined,
          size: MediaQuery.of(context).size.height/30,
        ),
      ),
      ButtonSegment(
        value: ThemeDarkState(),
        label: Icon(
          Icons.dark_mode_outlined,
          size: MediaQuery.of(context).size.height/30,
        ),
      ),
    ],
    selected: {state},
    onSelectionChanged: (Set<ThemeStates> selected) {
      context.read<ThemeCubit>().setThemeMode(selected.first);
    },
  );
  },
);
}