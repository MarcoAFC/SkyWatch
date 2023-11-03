import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/widgets/text/text_title.dart';
import 'package:skywatch/app/modules/video/presentation/pages/videos/bloc/video_list_bloc.dart';
import 'package:skywatch/app/modules/video/presentation/pages/videos/bloc/video_list_event.dart';
import 'package:skywatch/app/modules/video/presentation/pages/videos/bloc/video_list_state.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key, required this.bloc});
  final VideoListBloc bloc;

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetVideoListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(text: "Weather Videos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder(
            bloc: widget.bloc,
            builder: (context, snapshot) {
              if (snapshot is VideoListSuccessState) {
                return GridView.builder(
                  itemCount: snapshot.videos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16.0,
                            crossAxisCount: 2),
                    itemBuilder: ((context, index) {
                      var item = snapshot.videos[index];
                      return GestureDetector(
                        onTap: (){
                          //TODO: play
                        },
                        child: Stack(
                          children: [
                            Image.network(item.thumbnail, height: 200,),
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.play_arrow, color: Colors.white,),
                            )
                          ],
                        ),
                      );
                    }));
              }
              if (snapshot is VideoListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
