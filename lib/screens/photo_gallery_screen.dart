import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../services/permission_service.dart';
import 'photo_detail_screen.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});
  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _photos = [];

  Future<void> _pickImage(ImageSource source) async {
    final granted = await PermissionService.requestPermissions();
    if (!granted) return;

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
      setState(() => _photos.add(savedImage));
    }
  }

  void _deletePhoto(int index) {
    setState(() => _photos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Photo Gallery")),
      body: _photos.isEmpty 
        ? const Center(child: Text("Empty state: Tap + to add photos"))
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: _photos.length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 
                PhotoDetailScreen(file: _photos[index], tag: 'p$index', onDelete: () => _deletePhoto(index)))),
              child: Hero(tag: 'p$index', child: Image.file(_photos[index], fit: BoxFit.cover)),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(context: context, builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: const Icon(Icons.camera), title: const Text("Camera"), onTap: () { _pickImage(ImageSource.camera); Navigator.pop(context); }),
            ListTile(leading: const Icon(Icons.photo), title: const Text("Gallery"), onTap: () { _pickImage(ImageSource.gallery); Navigator.pop(context); }),
          ],
        )),
        child: const Icon(Icons.add),
      ),
    );
  }
}