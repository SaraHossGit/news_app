import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  String newsLink;

  NewsWebview({super.key, required this.newsLink});

  @override
  State<NewsWebview> createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  late WebViewController webViewController;
  bool isLoading = true;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = false;
          });
        },
      ))
      ..loadRequest(Uri.parse(widget.newsLink));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // await shareNews(widget.newsLink);
              },
              icon: const Icon(Icons.bookmark_border_outlined)),
          IconButton(
              onPressed: () async {
                await shareNews(widget.newsLink);
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WebViewWidget(controller: webViewController),
    );
  }

  Future<void> shareNews(newsLink) async {
    // Set the app link and the message to be shared
    final String message = 'Check out this! \n $newsLink';

    // Share the link and message using the share dialog
    await FlutterShare.share(
        title: 'News App', text: message, linkUrl: newsLink);
  }
}
