import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class CardSwiper extends StatefulWidget {
  final List<dynamic> peliculas;
  CardSwiper({@required this.peliculas});

  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        itemCount: widget.peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          widget.peliculas[index].uniqueId =
              '${widget.peliculas[index].id}-tarjeta';
          return Hero(
            tag: widget.peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(BottomSheetItem());
                },
                child: Image.network(
                  widget.peliculas[index].getPosterImg(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },

        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}

class BottomSheetItem extends StatefulWidget {
  const BottomSheetItem({Key key}) : super(key: key);

  @override
  _BottomSheetItemState createState() => _BottomSheetItemState();
}

class _BottomSheetItemState extends State<BottomSheetItem> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  //Reproductor de musica
  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();
//Slider
  Widget slider() {
    return Slider.adaptive(
      value: position.inSeconds.toDouble(),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      onChanged: (val) {
        seekToSec(val.toInt());
      },
      max: musicLength.inSeconds.toDouble(),
    );
  }

  seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };

    //cache.load("assets/mp3/new_life.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          slider(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
                IconButton(
                  onPressed: () {
                    if (!playing) {
                      cache.play("new_life.mp3");
                      setState(() {
                        playBtn = Icons.pause;
                        playing = true;
                      });
                    } else {
                      _player.pause();
                      setState(() {
                        playBtn = Icons.play_arrow;
                        playing = false;
                      });
                    }
                  },
                  icon: Icon(playBtn),
                ),
                IconButton(icon: Icon(Icons.skip_next), onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player.pause();
  }
}
