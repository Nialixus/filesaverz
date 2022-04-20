import '../state/filesaverstate.dart';

String pathGetter(FileSaverState state) {
  String pathResult = state.initialDirectory!.path;
  String nameResult =
      state.controller.text != '' ? state.controller.text : state.fileName;
  String dotSplitter = state.fileTypes.isEmpty
      ? ''
      : state.fileTypes[state.fileIndex].contains('.')
          ? ''
          : '.';
  String typeResult =
      state.fileTypes.isEmpty ? '' : state.fileTypes[state.fileIndex];

  return '$pathResult/$nameResult$dotSplitter$typeResult';
}
