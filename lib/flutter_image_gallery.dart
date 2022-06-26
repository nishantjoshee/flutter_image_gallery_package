import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class ImageGallery extends StatefulWidget {
  ImageGallery({
    Key? key,
    this.image = const [
      'https://media.istockphoto.com/photos/patan-picture-id637696304?b=1&k=20&m=637696304&s=170667a&w=0&h=KJIJqyXNjNFWtd7FAbCTPzNPp6kHIV34F4YVdMqKB6k=',
      'https://www.holidify.com/images/bgImages/KATHMANDU.jpg',
      'https://images.unsplash.com/photo-1605640840605-14ac1855827b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8a2F0aG1hbmR1fGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      'https://images.unsplash.com/photo-1589550165428-79eb74318795?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
    ],
    this.isAssetImage = false,
    this.imageVerticalPadding = 3,
    this.imageHorizontalPadding = 5,
    this.imageContainerDecoration = const BoxDecoration(),
    this.isGridView = false,
    this.imageContainerHeight = 200,
    this.imageContainerWidth = 200,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 2.0,
    this.mainAxisSpacing = 2.0,
  }) : super(key: key);
  List<String> image;
  bool isAssetImage;
  double imageHorizontalPadding;
  double imageVerticalPadding;
  Decoration imageContainerDecoration;
  bool isGridView;
  double imageContainerHeight;
  double imageContainerWidth;
  int crossAxisCount;
  double crossAxisSpacing;
  double mainAxisSpacing;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  @override
  Widget build(BuildContext context) {
    return widget.isGridView
        ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: widget.crossAxisSpacing,
              mainAxisSpacing: widget.mainAxisSpacing,
            ),
            itemCount: widget.image.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: widget.imageVerticalPadding,
                  horizontal: widget.imageHorizontalPadding,
                ),
                decoration: widget.imageContainerDecoration,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => GalleryWidget(
                        isAssetImage: widget.isAssetImage,
                        images: widget.image,
                        index: index,
                      ),
                    ),
                  ),
                  child: Ink.image(
                    image: widget.isAssetImage
                        ? AssetImage(widget.image[index]) as ImageProvider
                        : CachedNetworkImageProvider(widget.image[index]),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.image.length,
            itemBuilder: (context, index) {
              return Container(
                height: widget.imageContainerHeight,
                width: widget.imageContainerWidth,
                padding: EdgeInsets.symmetric(
                  vertical: widget.imageVerticalPadding,
                  horizontal: widget.imageHorizontalPadding,
                ),
                decoration: widget.imageContainerDecoration,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => GalleryWidget(
                        isAssetImage: widget.isAssetImage,
                        images: widget.image,
                        index: index,
                      ),
                    ),
                  ),
                  child: Ink.image(
                    image: widget.isAssetImage
                        ? AssetImage(widget.image[index]) as ImageProvider
                        : CachedNetworkImageProvider(widget.image[index]),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
  }
}

// ignore: must_be_immutable
class GalleryWidget extends StatefulWidget {
  GalleryWidget({
    Key? key,
    required this.images,
    this.index = 0,
    required this.isAssetImage,
  })  : pageController = PageController(initialPage: index),
        super(key: key);

  List<String> images;
  final int index;
  PageController pageController;
  bool isAssetImage;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int currentIndex = widget.index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: widget.pageController,
            itemCount: widget.images.length,
            builder: (context, index) {
              final urlImage = widget.images[index];

              return PhotoViewGalleryPageOptions(
                imageProvider: widget.isAssetImage
                    ? AssetImage(urlImage) as ImageProvider
                    : CachedNetworkImageProvider(urlImage),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
            onPageChanged: (index) => setState(() {
              currentIndex = index;
            }),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            child: Text(
              'Image ${currentIndex + 1} / ${widget.images.length}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
