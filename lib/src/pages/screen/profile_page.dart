// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../providers/check_rovider.dart';
import '../../theme/simta_color.dart';
import '../../widget/data_cache.dart';
import '../../widget/alert.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LocalAuthentication auth = LocalAuthentication();
  XFile? _profile;
  final picker = ImagePicker();
  CroppedFile? _croppedFile;
  FirebaseAuth aauth = FirebaseAuth.instance;
  String? imageurl;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        _profile = XFile(pickedFile.path);
      });
      _cropImage();
    } else {
      Get.snackbar("Gagal", "Dibatalkan Oleh Pengguna");
    }
    if (pickedFile == null) return;
  }

  Future<void> _cropImage() async {
    if (_profile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _profile!.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: SimtaColor.birubar,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });

        await uploadImageToFirebase();

        // print('ini gambar $imageurl');
      } else {
        Get.snackbar("Gagal", "Dibatalkan Oleh Pengguna");
      }
      if (croppedFile == null) return;
    }
  }

  Future<String> uploadImageToFirebase() async {
    int? iduser = await getUserIdFromSharedPreferences();
    if (iduser == null) {
      return '_';
    }
    String fileName = '$iduser-${basename(_croppedFile!.path)}';
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('ava')
        .child(fileName);

    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fileName},
    );

    firebase_storage.UploadTask uploadTask = ref.putFile(
      io.File(_croppedFile!.path),
      metadata,
    );

    try {
      firebase_storage.TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      if (kDebugMode) {
        print('Link Gambar Avatar: $downloadURL');
      }
      updateProfilePhoto(downloadURL);
      return downloadURL;
    } catch (error) {
      if (kDebugMode) {
        print('Error saat mengunggah gambar: $error');
      }
      return '_';
    }
  }

  Future<void> getUserData() async {
    User? currentUser = aauth.currentUser;
    if (currentUser != null) {
      setState(() {
        imageurl = currentUser.photoURL;
      });
    }
  }

  Future<void> updateProfilePhoto(String newPhotoURL) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await currentUser.updateProfile(photoURL: newPhotoURL);
        setState(() {
          imageurl = newPhotoURL;
        });
        Get.snackbar("Succes", "Foto profil berhasil diperbarui");
        if (kDebugMode) {
          print('URL gambar profil berhasil diperbarui.');
        }
      } catch (error) {
        if (kDebugMode) {
          print('Terjadi kesalahan saat memperbarui URL gambar profil: $error');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 17, left: 27, right: 27),
          color: Colors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              //Judul halaman
              const Text(
                "Profile",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff292d32),
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              //Box data user
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20),
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0x26000000)),
                ),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (imageurl != null)
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: SimtaColor.grey,
                            backgroundImage: NetworkImage(imageurl!),
                          )
                        else
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: SimtaColor.grey,
                            backgroundImage: AssetImage('assets/jpg/user.png'),
                          ),
                        Positioned(
                          bottom: -15,
                          left: 15,
                          child: RawMaterialButton(
                            onPressed: () async {
                              _showPicker(context);
                            },
                            elevation: 0.0,
                            fillColor: const Color(0xFFF5F6F9),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    FutureBuilder<List<String>?>(
                      future: getStringFromSharedPreferences(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<String>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Menampilkan indikator loading jika nilai belum tersedia
                          return shimmer(
                            height: 20,
                            width: 40,
                          );
                        } else if (snapshot.hasError) {
                          // Menampilkan pesan error jika terjadi kesalahan
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          List<String>? data = snapshot.data;
                          // Menampilkan nilai yang diambil dari Shared Preferences
                          if (data != null) {
                            return Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[0],
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    data[1],
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff757575),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    data[2],
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff757575),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //Akun & Keamanan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Akun & Keamanan",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     if (_supportState == _SupportState.supported) {
                  //       Navigator.push(
                  //         context,
                  //         CupertinoPageRoute(
                  //           builder: ((context) => const Account()),
                  //         ),
                  //       );
                  //     } else {
                  //       showDialog(
                  //         context: context,
                  //         builder: (ctx) => const AlertDialog(
                  //           title:
                  //               Text("Your device is not supported biometric"),
                  //         ),
                  //       );
                  //       return;
                  //     }
                  //   },
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Icon(Icons.fingerprint_outlined),
                  //           const SizedBox(
                  //             width: 21,
                  //           ),
                  //           const Text(
                  //             "Login Dengan Biometric",
                  //             style: TextStyle(
                  //                 fontFamily: 'OpenSans', fontSize: 15),
                  //           ),
                  //           const Spacer(),
                  //           SvgPicture.asset(
                  //             'assets/svg/Arrow_right.svg',
                  //             color: Colors.black,
                  //           ),
                  //         ],
                  //       ),
                  //       const Divider(
                  //         color: Color(0xffE3E3FE),
                  //         height: 14,
                  //         thickness: 1,
                  //         indent: 44,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: const [
                      Divider(
                        color: Color(0xffE3E3FE),
                        height: 14,
                        thickness: 1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed("/login",
                          arguments:
                              Provider.of<CheckProvider>(context, listen: false)
                                  .logout());
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/upload.svg',
                              height: 26,
                              width: 26,
                            ),
                            const SizedBox(
                              width: 21,
                            ),
                            const Text(
                              "Keluar",
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffE03A45)),
                            )
                          ],
                        ),
                        const Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
