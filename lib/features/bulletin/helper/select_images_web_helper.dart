// Imports for file picking and state management

/// Imports the FilePicker plugin to access platform file pickers.
/// Allows opening native file selection dialogs.
/// Works across iOS, Android, Windows, macOS and web.
/// Provides a unified API for multiple platforms.
import 'package:file_picker/file_picker.dart';

/// Imports kIsWeb boolean constant from Flutter.
/// Allows checking current runtime platform.
/// Can use to determine if running on web vs device.
/// Flutter provides platform detection capabilities.
import 'package:flutter/foundation.dart';

/// Imports Riverpod state management library.
/// Provides easy to use state management for Flutter.
/// Utilizes immutable state holders called providers.
/// Allows accessing state across widget tree.
/// Useful for persisting selection data.
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Function to select multiple images from web browser
/// and store selection in Riverpod state providers.
void selectImagesWebHelper({
  /// [WidgetRef] instance from Riverpod framework.
  /// Gives ability to obtain and modify state providers.
  /// Allows reading and updating selection state.
  /// Passed in from caller to access state providers.
  required WidgetRef ref,

  /// [StateProvider] that will contain image bytes selection.
  /// Holds a list of [Uint8List] representing images data.
  /// Each [Uint8List] contains the raw bytes of one image.
  /// List will be modified to add new selected images.
  required StateProvider<List<Uint8List>> selectedImagesStateProvider,

  /// [StateProvider] to persist metadata about selection.
  /// Will contain the overall [FilePickerResult].
  /// Useful to store for later access to metadata if needed.
  required StateProvider<FilePickerResult?> resultStateProvider,
}) async {
  /// Call [FilePicker] to open system file selection dialog.
  /// Configure with [allowMultiple] to enable multi-select.
  /// Use [FileType.image] to limit selection to only image files.
  /// Opens native file picker popup and returns result.
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.image,
  );

  /// Check if running on web platform using [kIsWeb].
  /// Also ensure we have a valid non-null [result].
  /// Currently only handles web, can add native platform support later.
  if (kIsWeb && result != null) {
    /// Initialize empty list to accumulate selected image data.
    /// Will contain [Uint8List] elements representing images.
    List<Uint8List> updatedImagesList = [];

    /// Iterate over each selected file in [result].
    /// Extracts bytes for each file and stores in list.
    for (var i = 0; i < result.count; i++) {
      /// Get the [PlatformFile] object for current file.
      /// Provides metadata and access to the file bytes.
      final PlatformFile file = result.files[i];

      /// Extract [Uint8List] bytes from file using [bytes] property.
      /// Contains the raw underlying image data.
      final Uint8List imageBytes = file.bytes!;

      /// Add to overall list that will be saved to state provider.
      updatedImagesList.add(imageBytes);

      /// Also directly add to existing state provider list.
      ref.read(selectedImagesStateProvider).add(imageBytes);
    }

    /// Update main state provider with full list of images.
    /// Overwrites state provider list with new selection.
    ref.read(selectedImagesStateProvider.notifier).state = updatedImagesList;

    /// Persist overall [FilePickerResult] in state provider.
    /// Useful to retain access to metadata if needed later.
    ref.read(resultStateProvider.notifier).update((state) => result);
  }
}
