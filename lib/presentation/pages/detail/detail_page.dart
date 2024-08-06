import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon_app_flutter/data/datasources/webtoon_api.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_detail_model.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_episode_model.dart';

import '../../../data/models/webtoon_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.data,
  });

  final WebtoonModel data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episode;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.data.id)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = WebtoonApi.getToonById(widget.data.id);
    episode = WebtoonApi.getLatestEpisodesById(widget.data.id);
    initPrefs();
  }

  onButtonTap({required String eId, required String wId}) async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$wId&no=$eId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () async {
                final likedToons = prefs.getStringList('likedToons');
                if (likedToons != null) {
                  if (isLiked) {
                    likedToons.remove(widget.data.id);
                  } else {
                    likedToons.add(widget.data.id);
                  }
                  await prefs.setStringList('likedToons', likedToons);
                }

                setState(() {
                  isLiked = !isLiked;
                });
              },
              icon: Icon(isLiked
                  ? Icons.favorite_outlined
                  : Icons.favorite_outline_outlined))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: widget.data.id,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          )
                        ]),
                    child: Image.network(
                      widget.data.thumb,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.about,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${snapshot.data!.genre} / ${snapshot.data!.age}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                  future: webtoon,
                ),
                const SizedBox(
                  height: 25,
                ),
                FutureBuilder(
                  future: episode,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            for (var episode in snapshot.data!)
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.green.shade400,
                                    borderRadius: BorderRadius.circular(20)),
                                child: GestureDetector(
                                  onTap: () {
                                    onButtonTap(
                                        eId: episode.id, wId: widget.data.id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            episode.title,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
