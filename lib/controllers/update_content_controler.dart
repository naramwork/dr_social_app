import 'dart:convert';

import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/app/helper_files/functions.dart';
import 'package:dr_social/models/dua.dart';
import 'package:dr_social/models/hadith.dart';
import 'package:dr_social/models/update_content.dart';
import 'package:dr_social/models/verse.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UpdateContentController extends ChangeNotifier {
  Verse? _verseOfTheDay;
  Dua? _duaOfTheDay;
  Hadith? _hadithOfTheDay;

  late List<Verse> _verses;
  late List<Dua> _duas;
  late List<Hadith> _hadiths;

  List<Verse> get verses => _verses;
  List<Dua> get duas => _duas;
  List<Hadith> get hadith => _hadiths;

  Verse? get verseOfTheDay => _verseOfTheDay;
  Dua? get duaOfTheDay => _duaOfTheDay;
  Hadith? get hadithOfTheDay => _hadithOfTheDay;

  Future<bool> getOfTheDayOffline() async {
    var updateContentBox = Hive.box<UpdateContent>(kUpdateContentBoxName);
    Box versesBox = Hive.box<Verse>(kVerseBoxName);
    Box duaBox = Hive.box<Dua>(kDuaBoxName);
    Box hadithBox = Hive.box<Hadith>(kHadithBoxName);
    List<UpdateContent> contentInfolist = updateContentBox.values.toList();
    List<Verse> versesList = versesBox.values.toList() as List<Verse>;
    List<Dua> duaList = duaBox.values.toList() as List<Dua>;
    List<Hadith> hadithList = hadithBox.values.toList() as List<Hadith>;
    setStartValues(
        contentInfolist: contentInfolist,
        versesList: versesList,
        hadithList: hadithList,
        duaList: duaList);
    if (_verseOfTheDay == null ||
        _hadithOfTheDay == null ||
        _duaOfTheDay == null) return Future.value(false);
    return Future.value(true);
  }

  Future<void> checkForUpdates() async {
    var updateContentBox = Hive.box<UpdateContent>(kUpdateContentBoxName);
    Box versesBox = Hive.box<Verse>(kVerseBoxName);
    Box duaBox = Hive.box<Dua>(kDuaBoxName);
    Box hadithBox = Hive.box<Hadith>(kHadithBoxName);

    Iterable<UpdateContent> updateContentIterble = [];
    bool isFirstTime = true;

    if (updateContentBox.isOpen && updateContentBox.isNotEmpty) {
      updateContentIterble = updateContentBox.values;
      isFirstTime = false;
    }
    String date = updateContentIterble.isNotEmpty
        ? updateContentIterble.first.lastUpdate
        : '';
    var url = Uri.parse('$kGetUpdateUrl/$date');

    try {
      final response = await http.get(url);
      final jsonExtractedList = json.decode(response.body);

      if (isFirstTime) {
        await firstTimeInit(
            body: jsonExtractedList,
            versesBox: versesBox,
            updateContentBox: updateContentBox,
            duaBox: duaBox,
            hadithBox: hadithBox);
      } else {
        await syncData(
            body: jsonExtractedList,
            versesBox: versesBox,
            updateContentBox: updateContentBox,
            duaBox: duaBox,
            hadithBox: hadithBox);
      }
    } catch (error) {
      print('fetchPosts: $error');
    }
  }

  Future<void> syncData({
    required var body,
    required Box versesBox,
    required Box updateContentBox,
    required Box duaBox,
    required Box hadithBox,
  }) async {
    List<UpdateContent> contentInfolist = [];
    List<Verse> versesList = versesBox.values.toList() as List<Verse>;
    List<Dua> duaList = duaBox.values.toList() as List<Dua>;
    List<Hadith> hadithList = hadithBox.values.toList() as List<Hadith>;

    //add UpdateContentInfo To Box
    if (updateContentBox.isOpen) {
      if (updateContentBox.isNotEmpty) {
        updateContentBox.clear();
      }
      final listData = body['content_info'] as List<dynamic>;
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      for (var versesObject in listData) {
        contentInfolist.add(UpdateContent.fromJson(versesObject, date));
      }
      updateContentBox.addAll(contentInfolist);
    }

    final verseslistData = body['verses'] as List<dynamic>;
    if (verseslistData.isNotEmpty) {
      if (versesBox.isOpen && versesBox.isNotEmpty) {
        Map<dynamic, Verse> verseMap = {};
        for (var verseData in verseslistData) {
          if (verseData['content'] != null) {
            var newVerse = Verse.fromJson(verseData);
            var verse = versesList.where((e) => e.id == verseData['id']);
            if (verse.isNotEmpty) {
              verseMap[verse.first.key] = newVerse;
            }
          }
        }
        versesBox.putAll(verseMap);
        versesList = versesBox.values.toList() as List<Verse>;
      }
    }

    final dualistData = body['dua'] as List<dynamic>;
    if (dualistData.isNotEmpty) {
      if (duaBox.isOpen && duaBox.isNotEmpty) {
        Map<dynamic, Dua> duaMap = {};
        for (var duaData in dualistData) {
          if (duaData['content'] != null) {
            var newDua = Dua.fromJson(duaData);
            var dua = duaList.where((e) => e.id == duaData['id']);

            if (dua.isNotEmpty) {
              duaMap[dua.first.key] = newDua;
            }
          }
        }
        duaBox.putAll(duaMap);
        duaList = duaBox.values.toList() as List<Dua>;
      }
    }
    final hadithlistData = body['hadith'] as List<dynamic>;
    if (hadithlistData.isNotEmpty) {
      if (hadithBox.isOpen && hadithBox.isNotEmpty) {
        Map<dynamic, Hadith> hadithMap = {};
        for (var hadithData in hadithlistData) {
          if (hadithData['content'] != null) {
            var newHadith = Hadith.fromJson(hadithData);
            var hadith = hadithList.where((e) => e.id == hadithData['id']);
            if (hadith.isNotEmpty) {
              hadithMap[hadith.first.key] = newHadith;
            }
          }
        }
        hadithBox.putAll(hadithMap);
        hadithList = hadithBox.values.toList() as List<Hadith>;
      }
    }

    setStartValues(
        contentInfolist: contentInfolist,
        versesList: versesList,
        hadithList: hadithList,
        duaList: duaList);
  }

/* Add all Content data to the local data base when first time opened th app */
  Future<void> firstTimeInit({
    required var body,
    required Box versesBox,
    required Box updateContentBox,
    required Box duaBox,
    required Box hadithBox,
  }) async {
    List<Hadith> hadithList = [];
    List<UpdateContent> contentInfolist = [];
    List<Verse> versesList = [];
    List<Dua> duaList = [];

    //add UpdateContentInfo To Box
    if (updateContentBox.isOpen) {
      if (updateContentBox.isNotEmpty) {
        updateContentBox.clear();
      }
      final listData = body['content_info'] as List<dynamic>;
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      for (var versesObject in listData) {
        contentInfolist.add(UpdateContent.fromJson(versesObject, date));
      }
      updateContentBox.addAll(contentInfolist);
    }

    // add Verses To VersesBox
    if (versesBox.isOpen) {
      if (versesBox.isNotEmpty) {
        versesBox.clear();
      }
      final verseslistData = body['verses'] as List<dynamic>;
      for (var versesObject in verseslistData) {
        if (versesObject['content'] != null) {
          versesList.add(Verse.fromJson(versesObject));
        }
      }

      versesBox.addAll(versesList);
    }

    //add DuaContent To Box
    if (duaBox.isOpen) {
      if (duaBox.isNotEmpty) {
        duaBox.clear();
      }
      final listData = body['dua'] as List<dynamic>;
      for (var duaObject in listData) {
        if (duaObject['content'] != null) {
          duaList.add(Dua.fromJson(duaObject));
        }
      }
      duaBox.addAll(duaList);
    }

    //add HadithContent To Box
    if (hadithBox.isOpen) {
      if (hadithBox.isNotEmpty) {
        hadithBox.clear();
      }
      final listData = body['hadith'] as List<dynamic>;
      for (var hadithObject in listData) {
        if (hadithObject['content'] != null) {
          hadithList.add(Hadith.fromJson(hadithObject));
        }
      }
      hadithBox.addAll(hadithList);
    }

    setStartValues(
        contentInfolist: contentInfolist,
        versesList: versesList,
        hadithList: hadithList,
        duaList: duaList);
  }

  /* set the contentOfTheDay and Notifiy listener */
  void setStartValues(
      {required List<UpdateContent> contentInfolist,
      required List<Verse> versesList,
      required List<Hadith> hadithList,
      required List<Dua> duaList}) {
    _hadiths = hadithList;
    _duas = duaList;
    for (UpdateContent content in contentInfolist) {
      switch (content.type) {
        case 'verse':
          DateTime date = DateTime.parse(content.lastUpdate);
          int startAt = content.startAt + daysBetween(date, DateTime.now());
          _verses = versesList
                  .where((element) => element.order >= startAt)
                  .toList() +
              versesList.where((element) => element.order < startAt).toList();

          _verseOfTheDay =
              versesList.firstWhere((verse) => verse.order >= startAt);
          break;
        case 'duas':
          // DateTime date = DateTime.parse(content.lastUpdate);
          // int startAt = content.startAt + daysBetween(date, DateTime.now());

          _duas = duaList;

          _duaOfTheDay =
              duaList.firstWhere((dua) => dua.order == DateTime.now().weekday);
          break;

        case 'hadith':
          DateTime date = DateTime.parse(content.lastUpdate);
          int startAt = content.startAt + daysBetween(date, DateTime.now());
          _hadiths = hadithList
                  .where((element) => element.order >= startAt)
                  .toList() +
              hadithList.where((element) => element.order < startAt).toList();
          _hadithOfTheDay =
              hadithList.firstWhere((hadith) => hadith.order >= startAt);
          break;
      }

      notifyListeners();
    }
  }
}
