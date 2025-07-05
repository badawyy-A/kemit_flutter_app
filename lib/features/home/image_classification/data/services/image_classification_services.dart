import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/image_classification/data/models/image_classification_response.dart';

class ChatBoServices {
  final Dio _dio;

  ChatBoServices(this._dio);

  Future<ChatBotResponse> chatBot(FormData formData) async {
    try {
      log('Sending request to server...');
      final response = await _dio.post(
        // 'http://10.0.2.2:3000/cnn_model/',
        'http://192.168.1.5:3000/cnn_model/',
        // 'http://localhost:3000/cnn_model/',
        data: formData,
        options: Options(
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          sendTimeout: const Duration(minutes: 10),
          receiveTimeout: const Duration(minutes: 10),
        ),
      );

      log('Response data: ${response.data}');
      
      // Parse JSON response
      final responseData = response.data as Map<String, dynamic>;
      log('Parsed response data: $responseData');
      
      final chatBotResponse = ChatBotResponse.fromJson(responseData);
      log('Created ChatBotResponse: videoUrl=${chatBotResponse.videoUrl}, name=${chatBotResponse.name}, description=${chatBotResponse.description}');
      
      return chatBotResponse;
    } catch (e, stackTrace) {
      log('Error in chatBot service: $e');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }
}

final chatBotServicesProvider = FutureProvider(
  (ref) async {
    Dio dio = await DioFactory.getDio();
    return ChatBoServices(dio);
  },
);
