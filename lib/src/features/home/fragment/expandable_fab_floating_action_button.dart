import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

import '../controller/image_upload_controller.dart';

class ExpandableFabFloatingActionButton extends StatelessWidget {
  const ExpandableFabFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageUploadController());
    return ExpandableFab(
      type: ExpandableFabType.up,
      pos: ExpandableFabPos.right,
      distance: 70,
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.black.withOpacity(.3),
      ),
      openButtonBuilder: DefaultFloatingActionButtonBuilder(
        heroTag: "Edit",
        fabSize: ExpandableFabSize.regular,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          AppImages.editIcon,
          color: Colors.black,
          size: 26,
        ),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        heroTag: "Close",
        fabSize: ExpandableFabSize.regular,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          AppImages.closeIcon,
          color: Colors.black,
          size: 26,
        ),
      ),
      children: [
        ReusableFloatingActionButton(
          iconName: 'Camera',
          icon: AppImages.cameraIcon,
          onPressed: () {
            final controller = Get.find<ImageUploadController>();
            controller
                .captureAndUploadImage(); // This opens the camera and uploads the image
          },
        ),
        ReusableFloatingActionButton(
          iconName: 'Scan',
          icon: AppImages.scanIcon,
          onPressed: () {},
        ),
        ReusableFloatingActionButton(
          iconName: 'Gallery',
          icon: AppImages.galleryIcon,
          onPressed: () {
            final controller = Get.find<ImageUploadController>();
            controller.pickAndUploadImageFromGallery();
          },
        ),
        ReusableFloatingActionButton(
          iconName: 'Note',
          icon: AppImages.noteIcon,
          onPressed: () {
            createBlankDocument();
          },
        ),
        ReusableFloatingActionButton(
          iconName: 'Folder',
          icon: AppImages.folderIcon,
          onPressed: () {},
        ),
      ],
    );
  }

  void createBlankDocument() async {
    List<NewPage> pages = [
      NewPage.fromPattern(PagePattern.blank, pageSize: PageSize.a5),
    ];

    final tempDir = await Pspdfkit.getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/blankPdf.pdf';

    var filePath =
        await PspdfkitProcessor.instance.generatePdf(pages, tempDocumentPath);

    await Pspdfkit.present(filePath!);

    Pspdfkit.pdfViewControllerWillDismiss = () => saveNote(filePath);
  }

  Future<void> saveNote(String filePath) async {
    String apiUrl = '${ApiConstants.baseUrl}shelf/notes/';

    dio.Dio dioInstance = dio.Dio();
    String fileName = filePath.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      "user_id": UserPreferences.userId,
      "file": await dio.MultipartFile.fromFile(filePath, filename: fileName),
    });
    try {
      var response = await dioInstance.post(apiUrl, data: formData);
      return response.data['id'];
    } catch (error) {
      print(error);
    }
  }
}
