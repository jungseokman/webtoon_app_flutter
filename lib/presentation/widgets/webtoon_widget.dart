import 'package:flutter/material.dart';
import 'package:webtoon_app_flutter/data/models/webtoon_model.dart';
import 'package:webtoon_app_flutter/presentation/pages/detail/detail_page.dart';

class WebtoonWidget extends StatelessWidget {
  const WebtoonWidget({
    super.key,
    required this.data,
  });

  final WebtoonModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailPage(data: data);
              },
            ),
          );
        },
        child: Column(
          children: [
            Hero(
              tag: data.id,
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: 300,
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
                  data.thumb,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
