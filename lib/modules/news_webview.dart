import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:news_app/cubit/bookmarks_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  String newsTitle;
  String newsDate;
  String newsSource;
  String newsImage;
  String newsLink;

  NewsWebview({super.key,
    required this.newsTitle,
    required this.newsDate,
    required this.newsSource,
    required this.newsImage,
    required this.newsLink,
  });

  @override
  State<NewsWebview> createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  late WebViewController webViewController;
  bool isLoading = true;
  bool isBookmarked = false;

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
    return BlocConsumer<BookmarksCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BookmarksCubit bookmarksCubit = BookmarksCubit().get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isBookmarked = true;
                        bookmarksCubit.insertRecord(
                            title: widget.newsTitle,
                            date: widget.newsDate,
                            source: widget.newsSource,
                            image: widget.newsImage,
                            link: widget.newsLink);
                      });
                    },
                    icon: isBookmarked ? const Icon(
                        Icons.bookmark_added_rounded) : const Icon(
                        Icons.bookmark_border_outlined)),
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
