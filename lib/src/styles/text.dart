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
    this.messageSucces = 'File has been saved',
    this.messageDenied = 'Storage Access Denied',
    this.popupNo = 'NO',
    this.popupYes = 'YES',
    this.popupTitle = 'Confirmation',
    this.popupInformation = 'File already exists.\nDo you want to replace it ?',
  });

  final String? titleSaveFile;
  final String? titlePickFile;
  final String? titlePickFiles;

  final String? buttonClose;
  final String? buttonSave;
  final String? buttonDone;
  final String? buttonFileTypes;

  final String? messageSucces;
  final String? messageDenied;

  final String? infoSelected;
  final String? infoEmptyFolder;

  final String? popupTitle;
  final String? popupInformation;
  final String? popupYes;
  final String? popupNo;
}
