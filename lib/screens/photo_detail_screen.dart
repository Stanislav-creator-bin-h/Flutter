import 'dart:io';
import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final File file;
  final String tag;
  final VoidCallback onDelete;

  const PhotoDetailScreen({super.key, required this.file, required this.tag, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.delete, color: Colors.white), 
          onPressed: () { onDelete(); Navigator.pop(context); })
        ],
      ),
      body: Center(
        child: Hero(tag: tag, child: InteractiveViewer(child: Image.file(file))),
      ),
    );
  }
}