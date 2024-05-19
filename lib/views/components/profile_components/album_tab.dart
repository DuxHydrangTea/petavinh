import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petavinh/views/components/my_hero.dart';

// ignore: must_be_immutable
class AlbumTab extends StatelessWidget {
  List<String> album;
  AlbumTab({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 750,
        child: Scrollbar(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: album.length,
              itemBuilder: (context, index) {
                return RawMaterialButton(
                  onPressed: null,
                  child: Hero(
                    tag: album[index],
                    child: GestureDetector(
                      onTap: () {
                        Get.to(MyHeroAlbum(tag: album[index]));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(album[index]))),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
