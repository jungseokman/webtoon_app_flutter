import 'package:flutter/material.dart';
import 'package:webtoon_app_flutter/data/datasources/webtoon_api.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_model.dart';
import 'package:webtoon_app_flutter/presentation/widgets/webtoon_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Future<List<WebtoonModel>> webtoons = WebtoonApi.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 웹툰'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          FutureBuilder(
            future: webtoons,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Expanded(child: makeList(snapshot));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink.shade100,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  PageView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var data = snapshot.data![index];
        return WebtoonWidget(data: data);
      },
      itemCount: snapshot.data!.length,
    );
  }
}
