import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model/upload_proposalawal_model.dart';

class UploadController extends GetxController {
  Future<String> uploadFileSempro(String filePath) async {
    String? filename;
    try {
      // openDownloadedFile(filePath);
      String url = 'http://d3ti.myfin.id/uploadproposalwal';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadTranskripNilaiSempro(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadtranskripnilai';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> revisiproposalFileSempro(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/revisiproposalwal';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadFileSemhas(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadproposalsemhas';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadBeritaAcara(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadberitaacara';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadPersetujuanSeminarHasil(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadpersetujuandosen';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> revisiproposalFileSemhas(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/revisiproposalsemhas';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadFileUjianTa(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadproposalakhir';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadBeritaAcaraKMM(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadberitaacarakmm';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadKRS(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadkrs';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadTranskripNilaiTA(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadtranskripnilaita';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadRekomedasiDospem(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadrekomendasidosen';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> revisiproposalFileUjianTA(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/revisiproposalakhir';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> laporanlengkap(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/laporanlengkap';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> halamanPengesahan(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/halamanpengesahan';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> halamanPersetujuan(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/halamanpersetujuan';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> manualBook(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/manualbook';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> ktp(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/ktp';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  // void openDownloadedFile(String filePath) async {
  //   final result = await OpenFile.open(filePath, type: 'application/pdf');
  //   if (result.type == ResultType.done) {
  //     if (kDebugMode) {
  //       print('File opened successfully');
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('Error opening file: ${result.message}');
  //     }
  //   }
  // }
}
