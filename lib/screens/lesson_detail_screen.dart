import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latemd/models/lesson.dart';
import 'package:latemd/services/database_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson? lesson;

  const LessonDetailScreen({super.key, this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
            if (widget.lesson != null) {
              _loadLessonToWebView();
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterBridge',
        onMessageReceived: (message) {
          _handleWebViewMessage(message.message);
        },
      )
      ..loadRequest(Uri.parse('asset:///assets/web/index.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson != null ? widget.lesson!.title : 'New Lesson'),
        actions: [
          if (widget.lesson != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                if (widget.lesson != null && widget.lesson!.key != null) {
                  await _databaseService.deleteLesson(widget.lesson!.key as int);
                  Navigator.pop(context);
                }
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Future<void> _loadLessonToWebView() async {
    if (widget.lesson != null) {
      final lessonJson = widget.lesson!.toJson();
      final script = "window.loadLessonData(${json.encode(lessonJson)});";
      await _webViewController.runJavaScript(script);
    }
  }

  void _handleWebViewMessage(String message) {
    // Handle messages from web view
    try {
      // Parse message as JSON
      final Map<String, dynamic> messageData = json.decode(message);
      final String action = messageData['action'];

      switch (action) {
        case 'saveLesson':
          _saveLessonFromWeb(messageData['data']);
          break;
        default:
          print('Unknown action: $action');
      }
    } catch (e) {
      print('Error handling web view message: $e');
    }
  }

  void _saveLessonFromWeb(Map<String, dynamic> lessonData) {
    try {
      final lesson = Lesson.fromJson(lessonData);

      if (widget.lesson != null) {
        // Update existing lesson
        lesson.createdAt = widget.lesson!.createdAt;
      }

      _databaseService.saveLesson(lesson).then((savedLesson) {
        print('Lesson saved successfully: ${savedLesson.key}');
      });
    } catch (e) {
      print('Error saving lesson: $e');
    }
  }
}
