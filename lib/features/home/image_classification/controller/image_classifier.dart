import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/image_classification/data/models/message_and_image_model.dart';
import 'package:morshd/features/home/image_classification/data/repo/image_classiy_repo.dart';
import 'dart:developer';

class ImageClassification extends AsyncNotifier<void> {
  File? image;
  String selectedLanguage = 'en'; // Default to English
  List<MessageAndImageModel> dataAndImage = [];

  @override
  FutureOr<void> build() {
    // This function is required by AsyncNotifier but isn't needed for this use case
  }

  Future<void> chatBot() async {
    if (image == null) {
      state = AsyncValue.error("No image selected", StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    try {
      log('Controller: Starting chatBot process...');
      final response = await ref.read(chatBotRepoProvider.future);
      log('Controller: Repository obtained, calling chatBot...');
      
      var result = await response.chatBot(image!, selectedLanguage);
      log('Controller: chatBot completed, processing result...');
      
      result.when(
        success: (data) {
          log('Controller: Success! Adding data to list...');
          log('Controller: Received data - name: ${data.name}, description: ${data.description}, videoUrl: ${data.videoUrl}');
          dataAndImage.add(
            MessageAndImageModel(
              name: data.name.toString(),
              description: data.description.toString(),
               videoUrl: data.videoUrl,
            ),
          );
          state = AsyncValue.data(null);
          log('Controller: Data added successfully');
        },
        failure: (failure) {
          log('Controller: Failure occurred: $failure');
          state = AsyncValue.error(failure, StackTrace.current);
        },
      );
    } catch (e, stackTrace) {
      log('Controller: Exception occurred: $e');
      log('Controller: Stack trace: $stackTrace');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void setLanguage(String languageCode) {
    selectedLanguage = languageCode;
  }
}

final chatBotControllerProvider =
    AsyncNotifierProvider<ImageClassification, void>(
  ImageClassification.new,
);
