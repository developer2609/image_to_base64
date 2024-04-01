import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  //
  // void _toggleImageVisibility() {
  //   setState(() {
  //     imageVisible = !imageVisible;
  //   });
  // }
  String base64String = '';

  ImagetoBase64() async {

    // path of image
    String _imagePath = "assets/images/download.jpeg";
    File _imageFile = File(_imagePath);

    // Read bytes from the file object
    Uint8List _bytes = await _imageFile.readAsBytes();

    // base64 encode the bytes
    String _base64String = base64.encode(_bytes);
    setState(() {
      base64String = _base64String;
      print(_base64String);
    });
  }
  Base64ToImage(){
    String sbase64String =base64String ; // Replace this with your actual Base64 string
    Uint8List bytes = base64.decode(base64String);

  }

  @override
  Widget build(BuildContext context) {
    // String sbase64String =base64String ; // Replace this with your actual Base64 string

    // Decode the Base64 string to bytes
    Uint8List bytes = base64.decode(base64String);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Image to Base64 String'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // child: Image.asset('assets/images/download.jpeg'),
                ),
                ElevatedButton(
                    onPressed: () {
                      ImagetoBase64();
                      // Image.asset('assets/images/mobile.jpg');
                    },
                    child: Text("Convert")
                ),
                Text(
                  base64String,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),

                ElevatedButton(onPressed: (){
                  Base64ToImage();
                  // sbase64String;
                }, child: Text("Unconvert")),
                Image.memory(bytes,height: 100,width: 200,),
                SizedBox(height: 10,),
                Text("3x4 image"),
                ImageFromBase64(bbase64String: base64String,)

                // Image.memory(bytes,height: 200,width: 100,)
                // ElevatedButton(onPressed: _toggleImageVisibility, child: Visibility(visible: imageVisible,
                //     child: Image.asset('assets/images/mobile.jpg',width: 200,
                //       height: 200,
                //       fit: BoxFit.cover,)),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ImageFromBase64 extends StatelessWidget {
  final String bbase64String;

  const ImageFromBase64({Key? key, required this.bbase64String}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode base64 string into bytes
    List<int> bytes = base64Decode(bbase64String);
    if (bytes.length != 64) {
      throw Exception('Invalid image size. Expected 48 bytes.');
    }
    // Ensure image size is 3x4
    assert(bytes.length == 3 * 4 * 4); // Assuming RGBA format (4 bytes per pixel)

    // Display image
    return Image.memory(
      Uint8List.fromList(bytes),
      width: 3*100.0,
      height: 4*100.0,
    );
  }
}