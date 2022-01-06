import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mobial/widgets/info_card.dart';

class Custom_duty extends StatefulWidget {
  Custom_duty({Key? key}) : super(key: key);

  @override
  _Custom_dutyState createState() => _Custom_dutyState();
}

class _Custom_dutyState extends State<Custom_duty> {
  TextEditingController searchText = TextEditingController();
  File? selectedImage;
  var list;
  List<String> item = [];
  bool isShow = false;
  List<InfoCard> cardWidgets = [];
  Map<String, InfoCard> info_item = {};
  String selectedItem = "";
  InfoCard cardWidget = InfoCard(
    title: "",
  );
  handleCamera(BuildContext context) async {
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 690);
    setState(() {
      this.selectedImage = File(file!.path);
    });
    var name = selectedImage!.path.split("/").last;
    print(name);

    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mobial;AccountKey=625C6GU3riuquxpJbkz86DNcCYd4iqFS5RJNpOIW+imfdIz8UI429OXAAZr7gr0fHyKFLhMA7gF1fmgw/Zt48g==');
    await storage.putBlob('/mobialc/$name',
        bodyBytes: selectedImage!.readAsBytesSync(),
        contentType: lookupMimeType('$name'),
        type: BlobType.BlockBlob);

    String selectedPath = '/mobialc/$name';

    var val = storage.uri();
    String finalUrl = "$val" + "mobialc/$name";
    print(finalUrl);

    var b_url = Uri.parse("https://mobial.herokuapp.com/api/scan_cduty");
    var response = await http.post(b_url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({'url': finalUrl}));
    print(response.statusCode);
    print(response.body);
  }

  getList() async {
    var url = Uri.parse("https://mobial.herokuapp.com/api/get_cduty");
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    setState(() {
      list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        info_item[list[i]['name']] = InfoCard(
          title: list[i]['name'],
          body: list[i]['description'],
          subInfoText: list[i]['duty'],
        );
      }
      for (int i = 0; i < list.length; i++) {
        item.add(list[i]["name"]);
      }
    });
  }

  handleChooseFromGallery(BuildContext context) async {
    Navigator.pop(context);
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.selectedImage = File(file!.path);
    });
    var name = selectedImage!.path.split("/").last;
    print(name);

    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mobial;AccountKey=625C6GU3riuquxpJbkz86DNcCYd4iqFS5RJNpOIW+imfdIz8UI429OXAAZr7gr0fHyKFLhMA7gF1fmgw/Zt48g==');
    await storage.putBlob('/mobialc/$name',
        bodyBytes: selectedImage!.readAsBytesSync(),
        contentType: lookupMimeType('$name'),
        type: BlobType.BlockBlob);

    String selectedPath = '/mobialc/$name';

    var val = storage.uri();
    String finalUrl = "$val" + "mobialc/$name";
    print(finalUrl);

    var b_url = Uri.parse("https://mobial.herokuapp.com/api/scan_cduty");
    var response = await http.post(b_url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({'url': finalUrl}));
    print(response.statusCode);
    print(response.body);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Camera'),
                      onTap: () {
                        handleCamera(context);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Photo Gallery'),
                    onTap: () {
                      handleChooseFromGallery(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  onSelectItem(String? selectedItem) {
    for (var i in list) {
      if (i['name'] == selectedItem) {
        print(i);
        cardWidgets.add(InfoCard(
          title: i['name'],
          subInfoText: i['duty'],
          body: i['description'],
        ));
        setState(() {
          isShow = true;
        });
      }
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: DropdownSearch<String>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              showSelectedItem: true,
              items: item,
              label: "Items",
              onChanged: (String? item) => {
                setState(() {
                  selectedItem = item!;
                  isShow = true;
                })
              },
              selectedItem: "Select Item",
            ),
          ),
          IconButton(
            onPressed: () => {_showPicker(context)},
            icon: Icon(Icons.add_a_photo),
          ),
          this.isShow
              ? (info_item[selectedItem]!)
              : Expanded(
                  child: Image(
                  image: AssetImage('assets/img/duty.png'),
                )),
        ],
      ),
    );
  }
}

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {required Key key,
      required this.icon,
      required this.color,
      required this.text,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
