import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/services.dart'; // Not directly used in this snippet but often useful
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; // For File and Directory operations
import 'package:path_provider/path_provider.dart'; // For getApplicationDocumentsDirectory
import 'package:uuid/uuid.dart'; // For generating unique filenames
import 'package:video_player/video_player.dart'; // **The essential import for video playback**

// You might not need these for the video player itself, but keeping them as they were in your original code
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class ImageClassificationResponse extends StatelessWidget {
  final String videoUrl;
  final String name;
  final String description;

  const ImageClassificationResponse({
    super.key,
    required this.videoUrl,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    print('ImageClassificationResponse: Building with - videoUrl: $videoUrl, name: $name, description: $description');
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                      child: SizedBox(
                        width: 370,
                        height: 370,
                        // This is where your VideoPlayerWidget will be displayed
                        child: VideoPlayerWidget(videoUrl: videoUrl),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(52.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Center(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String? _localVideoPath; // To store the path of the downloaded video

  @override
  void initState() {
    super.initState();
    print('VideoPlayerWidget: Initializing with URL: ${widget.videoUrl}');

    String videoUrl = widget.videoUrl;

    // Check if it's a network URL to download, otherwise treat as local file
    if (videoUrl.startsWith('http://') || videoUrl.startsWith('https://')) {
      _downloadAndInitializeVideo(videoUrl);
    } else {
      // It's already a local file path
      _localVideoPath = videoUrl;
      _initializeVideoPlayer(VideoPlayerController.file(File(_localVideoPath!)));
    }
  }

  // Handles downloading the video from a network URL
  Future<void> _downloadAndInitializeVideo(String videoUrl) async {
    try {
      setState(() {
        _isDownloading = true;
        _downloadProgress = 0.0;
      });

      final Directory appDir = await getApplicationDocumentsDirectory();
      final Directory videoDir = Directory('${appDir.path}/videos');

      if (!await videoDir.exists()) {
        await videoDir.create(recursive: true);
      }

      final String fileName = 'video_${const Uuid().v4()}.mp4';
      final String filePath = '${videoDir.path}/$fileName';

      print('VideoPlayerWidget: Downloading video to: $filePath');

      final http.Client client = http.Client();
      final http.Request request = http.Request('GET', Uri.parse(videoUrl));
      final http.StreamedResponse response = await client.send(request);

      if (response.statusCode == 200) {
        final int totalBytes = response.contentLength ?? 0;
        int downloadedBytes = 0;

        final File file = File(filePath);
        final IOSink sink = file.openWrite();

        await for (final List<int> chunk in response.stream) {
          sink.add(chunk);
          downloadedBytes += chunk.length;

          if (totalBytes > 0) {
            setState(() {
              _downloadProgress = downloadedBytes / totalBytes;
            });
          }
        }

        await sink.close();
        client.close();

        setState(() {
          _isDownloading = false;
          _localVideoPath = filePath; // Set the local path after download
        });

        print('VideoPlayerWidget: Video downloaded successfully to: $_localVideoPath');
        // Initialize the video player with the downloaded file
        _initializeVideoPlayer(VideoPlayerController.file(File(_localVideoPath!)));
      } else {
        throw Exception('Failed to download video: ${response.statusCode}');
      }
    } catch (e) {
      print('VideoPlayerWidget: Error downloading video: $e');
      setState(() {
        _isDownloading = false;
        _isInitialized = false; // Indicate error in initialization
      });
    }
  }

  // Initializes the VideoPlayerController
  void _initializeVideoPlayer(VideoPlayerController controller) {
    _controller = controller;
    _controller.initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
      // Optional: uncomment to autoplay after initialization
      // _controller.play();
    }).catchError((error) {
      print('VideoPlayerWidget: Error initializing video player: $error');
      setState(() {
        _isInitialized = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Important: dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // The video_player plugin generally handles web, but if you specifically
      // want to show a message for *local file paths* on web, this is still valid.
      // For network URLs, video_player.network would work directly on web.
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: const Center(
          child: Text(
            'Video playback from local files is not directly supported on web via dart:io. Please provide a network URL.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_isDownloading) {
      // Show download progress
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                value: _downloadProgress,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 16.h),
              Text(
                'Downloading video... ${(_downloadProgress * 100).toInt()}%',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    // Show a loading indicator if not yet initialized, but not downloading
    if (!_isInitialized) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading video...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    // Once initialized, display the video and controls
    return Stack(
      alignment: Alignment.center, // Center the play button
      children: [
        // Video player
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        // Play/Pause button overlay
        GestureDetector(
          onTap: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          child: AnimatedOpacity(
            opacity: _controller.value.isPlaying ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              color: Colors.black26, // Semi-transparent overlay
              child: Center(
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 80.sp,
                ),
              ),
            ),
          ),
        ),
        // Video progress indicator (positioned at the bottom)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Theme.of(context).primaryColor,
              bufferedColor: Colors.white54,
              backgroundColor: Colors.white24,
            ),
          ),
        ),
      ],
    );
  }
}