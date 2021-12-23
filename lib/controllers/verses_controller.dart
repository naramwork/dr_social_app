import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/models/verse.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class VersesControler extends ChangeNotifier {
  late List<Verse> _verses;

  List<Verse> get verses => _verses;

  Future<void> fetchVerses(
      int pageNumber, PagingController<int, Verse> _pagingController) async {
    List<Verse> newVerseList = [];
    var url = Uri.parse('$kGetVersesUrl$pageNumber');
    try {
      final response = await http.get(url);
      final jsonExtractedList = json.decode(response.body);
      //final previousJsonList = jsonExtractedList['previous'];
      final verseListData =
          jsonExtractedList['verses']['data'] as List<dynamic>;
      final lastPage = jsonExtractedList['verses']['last_page'];
      for (var verseData in verseListData) {
        final verse = Verse.fromJson(verseData);
        newVerseList.add(verse);
      }
      if (lastPage == pageNumber) {
        // 3
        _pagingController.appendLastPage(newVerseList);
      } else {
        final nextPageKey = pageNumber + 1;
        _pagingController.appendPage(newVerseList, nextPageKey);
      }
    } catch (error) {
      print('fetchPosts: $error');
    }
  }
}
