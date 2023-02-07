import 'dart:typed_data';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_picker/image_picker.dart';



class FillOut extends StatefulWidget {
  const FillOut({super.key});

  @override
  State<FillOut> createState() => _FillOutState();
}

class _FillOutState extends State<FillOut> {
  
    File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  Future <void> GetImg() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = webImage as File?;
        });}
  }



  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 100,
      ),
      Container(
        height: 600,
        width: 450,
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(2)
        ),
        child: SingleChildScrollView(child: 
          Column(crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text('Last Opp'),

            ElevatedButton(onPressed: () async{
              GetImg();
            }, child: (
              const Text('Velg')
            )),

            ElevatedButton(onPressed: (){

            }, child: (
              const Text('Last')
            )),
            
            Center(
    child: webImage == null
        ? const CircularProgressIndicator()
        : Image.memory(
            Uint8List.fromList(webImage!),
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          )),

          ],)
        ),
      )
    ],);
  }
}