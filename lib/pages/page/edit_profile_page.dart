import 'dart:convert';
import 'package:mobial/widgets/progress.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobial/model/user.dart';
import 'package:mobial/utils/user_preferences.dart';
import 'package:mobial/widgets/header.dart';
import 'package:mobial/widgets/profile_widget.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';

final LocalStorage storage = new LocalStorage('mobial');

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;
  User user = UserPreferences.myUser;
  TextEditingController? nameController;
  TextEditingController? dobController;
  TextEditingController? phoneController;
  TextEditingController? usernameController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phone);
    usernameController = TextEditingController(text: user.username);
    dobController = TextEditingController(text: user.dob);
  }

  TextEditingController searchText = TextEditingController();
  File? selectedImage;
  void addItemsToLocalStorage(var data) async {
    await storage.setItem('user', data);
    print("hello");
    print(storage.getItem('user'));
  }

  handleCamera(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 690);
    setState(() {
      this.selectedImage = File(file!.path);
    });
    var name = selectedImage!.path.split("/").last;
    print(name);

    var storage1 = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mobials;AccountKey=MGK+5fB/xysTXXPvG7RnAYnQocXBCtr8oKbkv64qtlX1dpjmq1BWtJCg6gMmvfQ0EpaOXdMTyrT3+AStoRUMqQ==');
    await storage1.putBlob('/mobial/$name',
        bodyBytes: selectedImage!.readAsBytesSync(),
        contentType: lookupMimeType('$name'),
        type: BlobType.BlockBlob);

    var val = storage1.uri();
    String finalUrl = "$val" + "mobial/$name";
    print(finalUrl);

    var bUrl = Uri.parse("https://mobial.azurewebsites.net/api/update_profile");
    var response = await http.post(bUrl,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({'email': user.email, 'picture': finalUrl}));
    print(response.statusCode);
    print(response.body);
    var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
    var response1 = await http.post(bUrl1,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({'email': user.email}));
    print(response1.statusCode);
    print(response1.body);
    storage.clear();
    var data = jsonDecode(response1.body);
    addItemsToLocalStorage(data);
    setState(() {
      isLoading = false;
    });
  }

  handleChooseFromGallery(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Navigator.pop(context);
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.selectedImage = File(file!.path);
    });
    var name = selectedImage!.path.split("/").last;
    print(name);

    var storage1 = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mobials;AccountKey=MGK+5fB/xysTXXPvG7RnAYnQocXBCtr8oKbkv64qtlX1dpjmq1BWtJCg6gMmvfQ0EpaOXdMTyrT3+AStoRUMqQ==');
    await storage1.putBlob('/mobial/$name',
        bodyBytes: selectedImage!.readAsBytesSync(),
        contentType: lookupMimeType('$name'),
        type: BlobType.BlockBlob);

    var val = storage1.uri();
    String finalUrl = "$val" + "mobial/$name";
    print(finalUrl);

    var bUrl = Uri.parse("https://mobial.azurewebsites.net/api/update_profile");
    var response = await http.post(bUrl,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'picture': finalUrl,
        }));
    print(response.statusCode);
    var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
    var response1 = await http.post(bUrl1,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({'email': user.email}));
    print(response1.statusCode);
    storage.clear();
    var data = jsonDecode(response1.body);
    addItemsToLocalStorage(data);
    setState(() {
      print(response.body);
      isLoading = false;
    });
  }

  editName() async {
    setState(() {
      isLoading = true;
    });
    print(nameController!.text);
    var url = Uri.parse("https://mobial.azurewebsites.net/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'name': nameController!.text,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
      var response1 = await http.post(bUrl1,
          headers: <String, String>{
            'content-type': 'application/json',
            "Accept": "application/json",
            "charset": "utf-8"
          },
          body: json.encode({'email': user.email}));
      print(response1.statusCode);
      print(response1.body);
      storage.clear();
      var data = jsonDecode(response1.body);
      addItemsToLocalStorage(data);
      // setState(() {
      //   storage.getItem("user")['name'] = nameController!.text;
      // });
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    setState(() {
      isLoading = false;
    });
  }

  editDob() async {
    setState(() {
      isLoading = true;
    });
    print(dobController!.text);
    var url = Uri.parse("https://mobial.azurewebsites.net/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'dob': dobController!.text,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
      var response1 = await http.post(bUrl1,
          headers: <String, String>{
            'content-type': 'application/json',
            "Accept": "application/json",
            "charset": "utf-8"
          },
          body: json.encode({'email': user.email}));
      print(response1.statusCode);
      print(response1.body);
      storage.clear();
      var data = jsonDecode(response1.body);
      addItemsToLocalStorage(data);
      // setState(() {
      //   storage.getItem("user")['dob'] = dobController!.text;
      // });
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    setState(() {
      isLoading = false;
    });
  }

  editUsername() async {
    setState(() {
      isLoading = true;
    });
    print(usernameController!.text);
    var url = Uri.parse("https://mobial.azurewebsites.net/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'username': usernameController!.text,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
      var response1 = await http.post(bUrl1,
          headers: <String, String>{
            'content-type': 'application/json',
            "Accept": "application/json",
            "charset": "utf-8"
          },
          body: json.encode({'email': user.email}));
      print(response1.statusCode);
      print(response1.body);
      storage.clear();
      var data = jsonDecode(response1.body);
      addItemsToLocalStorage(data);
      // setState(() {
      //   storage.getItem("user")['username'] = usernameController!.text;
      // });
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    setState(() {
      isLoading = false;
    });
  }

  editPhone() async {
    setState(() {
      isLoading = true;
    });
    print(phoneController!.text);
    var url = Uri.parse("https://mobial.azurewebsites.net/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'phone': phoneController!.text,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
      var response1 = await http.post(bUrl1,
          headers: <String, String>{
            'content-type': 'application/json',
            "Accept": "application/json",
            "charset": "utf-8"
          },
          body: json.encode({'email': user.email}));
      print(response1.statusCode);
      print(response1.body);
      storage.clear();
      var data = jsonDecode(response1.body);
      addItemsToLocalStorage(data);
      // setState(() {
      //   storage.getItem("user")['phone'] = phoneController!.text;
      // });
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    setState(() {
      isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) => Center(
        child: Builder(
          builder: (context) => Scaffold(
              appBar: header(context),
              body: !isLoading
                  ? (ListView(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      physics: BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 16),
                        ProfileWidget(
                          imagePath: user.imagePath,
                          isEdit: false,
                          onClicked: () => {_showPicker(context)},
                        ),
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            editName();
                          },
                          icon: const Icon(Icons.check),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            editPhone();
                          },
                          icon: const Icon(Icons.check),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            editUsername();
                          },
                          icon: const Icon(Icons.check),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DOB(dd-mm-yyyy)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: dobController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            editDob();
                          },
                          icon: const Icon(Icons.check),
                        ),
                      ],
                    ))
                  : circularProgress()),
        ),
      );
}
