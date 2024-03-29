import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as imagePicker;
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class ImagePickerBox extends StatefulWidget {
  @override
  _ImagePickerBoxState createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {
  imagePicker.XFile? _imageFile;
  final imagePicker.ImagePicker _picker = imagePicker.ImagePicker();

  Future getImage() async {
    final image =
        await _picker.pickImage(source: imagePicker.ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: 160,
        height: 160,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            image: _imageFile == null
                ? _recipe.editingMood && _recipe.hasImg
                    ? DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(_recipe.imageUrl!))
                    : null
                : DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(File(_imageFile!.path)))),
        child: Center(
          child: _imageFile == null
              ? _recipe.editingMood && _recipe.hasImg
                  ? null
                  : const Icon(
                      Icons.image_outlined,
                      size: 50,
                    )
              : null,
        ),
      ),
      onTap: () {
        print('Tap! Tap');
        getImage().then((_) {
          _recipe.addImage(_imageFile);
        });
      },
    );
  }
}
