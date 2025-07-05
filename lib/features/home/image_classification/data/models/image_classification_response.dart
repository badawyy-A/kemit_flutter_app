/*class ChatBotResponse {
  ChatBotResponse({
    this.name,
  });

  final String? name;

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) {
    print("API Response: \$json");
    return ChatBotResponse(
     name: json["prediction"] ?? "Unknown",
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "file": name,
  //     };
}
*/


class ChatBotResponse {
  ChatBotResponse({
    required this.videoUrl,
    required this.name,
    required this.description,
  });

 final String videoUrl;
  final String name;
  final String description;

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) {
    return ChatBotResponse(
     videoUrl: json['video_path'] as String? ?? '',
      name: json['king_name'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? 'No description available.',
    );
  }

  
}
