import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/toast_app.dart';
import 'package:uuid/uuid.dart';

Future<String> uploadImage(webImage, {String? dir}) async {
  final uuid = const Uuid().v4();
  try {
    final ref = FirebaseStorage.instance
        .ref()
        .child(dir ?? 'userImages')
        .child('$uuid.jpg');

    await ref.putData(webImage);

    return await ref.getDownloadURL();
  } on FirebaseException catch (_, e) {
    toastApp(message: e.toString());
    return "";
  } // fb.StorageReference storageRef =
  //     fb.storage().ref().child('productsImages').child(_uuid + 'jpg');
  // final fb.UploadTaskSnapshot uploadTaskSnapshot =
  //     await storageRef.put(kIsWeb ? webImage : _pickedImage).future;
}
