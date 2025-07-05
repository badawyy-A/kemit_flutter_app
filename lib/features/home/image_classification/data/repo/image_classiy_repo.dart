import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/image_classification/data/models/image_classification_response.dart';
import 'package:morshd/features/home/image_classification/data/services/api_result_chat.dart';
import 'package:morshd/features/home/image_classification/data/services/image_classification_services.dart';
import 'package:image/image.dart' as img;

class ChatBotRepo {
  final ChatBoServices _chatBoServices;

  ChatBotRepo(this._chatBoServices);

  Future<ApiResultChat<ChatBotResponse>> chatBot(File image, String language) async {
    // Log image size
    log('Original image size: ${await image.length()} bytes');
    
    // Resize image to reduce processing time
    final bytes = await image.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    
    if (originalImage != null) {
      // Resize to max 512x512 pixels
      final resizedImage = img.copyResize(
        originalImage,
        width: originalImage.width > 512 ? 512 : originalImage.width,
        height: originalImage.height > 512 ? 512 : originalImage.height,
      );
      
      final resizedBytes = img.encodeJpg(resizedImage, quality: 85);
      final resizedFile = File('${image.parent.path}/resized_${image.uri.pathSegments.last}');
      await resizedFile.writeAsBytes(resizedBytes);
      
      log('Resized image size: ${await resizedFile.length()} bytes');
      
      var response = await _chatBoServices.chatBot(FormData.fromMap({
        "file": await MultipartFile.fromFile(resizedFile.path),
        "lang": language,
      }));
      
      // Clean up resized file
      await resizedFile.delete();
      
      try {
         return ApiSuccessChat(response);
      } catch (failure) {
        return ApiFailureChat(failure.toString());
      }
    } else {
      return ApiFailureChat("Failed to process image");
    }
  }
}

final chatBotRepoProvider = FutureProvider((ref) async {
  final chatBotServices = await ref.watch(chatBotServicesProvider.future);

  return ChatBotRepo(chatBotServices);
});

