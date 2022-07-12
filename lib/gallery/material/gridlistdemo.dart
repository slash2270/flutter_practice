// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum GridListDemoType{
  imageOnly,
  header,
  footer
}

class GridListDemo extends StatelessWidget {
  const GridListDemo({Key? key, required this.type}) : super(key: key);

  final GridListDemoType type;

  List<_Photo> _photos(BuildContext context) {
    return [
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title1',
        subtitle: 'subtitle1',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title2',
        subtitle: 'subtitle2',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title3',
        subtitle: 'subtitle3',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title4',
        subtitle: 'subtitle4',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title5',
        subtitle: 'subtitle5',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title6',
        subtitle: 'subtitle6',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title7',
        subtitle: 'subtitle7',
      ),
      _Photo(
        assetName: 'ellen.jpeg',
        title: 'title8',
        subtitle: 'subtitle8',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        restorationId: 'grid_view_demo_grid_offset',
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _photos(context).map<Widget>((photo) {
          return _GridDemoPhotoItem(
            photo: photo,
            tileStyle: type,
          );
        }).toList(),
    );
  }
}

class _Photo {
  _Photo({
    required this.assetName,
    required this.title,
    required this.subtitle,
  });

  final String assetName;
  final String title;
  final String subtitle;
}

/// Allow the text size to shrink to fit in the space
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  const _GridDemoPhotoItem({
    Key? key,
    required this.photo,
    required this.tileStyle,
  }) : super(key: key);

  final _Photo photo;
  final GridListDemoType tileStyle;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'images/ellen.jpeg',
        fit: BoxFit.cover,
      ),
    );

    switch (tileStyle) {
      case GridListDemoType.imageOnly:
        return image;
      case GridListDemoType.header:
        return GridTile(
          header: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: _GridTitleText(photo.title),
              backgroundColor: Colors.black45,
            ),
          ),
          child: image,
        );
      case GridListDemoType.footer:
        return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: _GridTitleText(photo.title),
              subtitle: _GridTitleText(photo.subtitle),
            ),
          ),
          child: image,
        );
    }
  }
}