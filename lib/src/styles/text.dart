part of 'package:filesaverz/filesaverz.dart';

/// List of displayed text in entire [FileSaver].
class FileSaverText {
  /// Customizing displayed text in entire [FileSaver].
  const FileSaverText({
    this.titlePickFile = 'Pick File',
    this.titleSaveFile = 'Save File',
    this.titlePickFiles = 'Pick Files',
    this.buttonSave = 'Save',
    this.buttonDone = 'Done',
    this.buttonClose = 'Close',
    this.buttonFileTypes = 'File Types',
    this.infoEmptyFolder = 'Folder is empty',
    this.infoSelected = 'File has been selected',
    this.infoMultipleSelected = 'Files have been selected',
    this.messageSucces = 'File has been saved',
    this.messageDenied = 'Storage Access Denied',
    this.popupNo = 'NO',
    this.popupYes = 'YES',
    this.popupTitle = 'Confirmation',
    this.popupInformation = 'File already exists.\nDo you want to replace it ?',
  });

  /// Default value is `Save File`.
  final String? titleSaveFile;

  /// Default value is `Pick File`.
  final String? titlePickFile;

  /// Default value is `Pick Files`.
  final String? titlePickFiles;

  /// Default value is `Close`.
  final String? buttonClose;

  /// Default value is `Save`.
  final String? buttonSave;

  /// Default value is `Done`.
  final String? buttonDone;

  /// Default value is `File Types`.
  final String? buttonFileTypes;

  /// Default value is `File has been saved`.
  final String? messageSucces;

  /// Default value is `Storage Access Denied`.
  final String? messageDenied;

  /// Default value is `File has been selected`.
  final String? infoSelected;

  /// Default value is `Files have been selected`.
  final String? infoMultipleSelected;

  /// Default value is `Folder is empty`.
  final String? infoEmptyFolder;

  /// Default value is `Confirmation`.
  final String? popupTitle;

  /// Default value is `File already exists.\nDo you want to replace it ?`.
  final String? popupInformation;

  /// Default value is `YES`.
  final String? popupYes;

  /// Default value is `NO`.
  final String? popupNo;
}
