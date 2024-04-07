Notespaedia
This is a Flutter application called Notespaedia. It is a application that caters mainly to NEET
aspirants by providing books and content written by experts to students. This app uses API endpoints
to serve PDF books from the server to end users. The PDF reader used by the application is PSPDFKit.
Due to limited support on the PSPDFKit flutter package native channel implementation of the SDK has
been done for both Android & iOS counterparts of the application.

[PSPDFKit iOS guide](https://pspdfkit.com/guides/ios/)

[PSPDFKit Android guide](https://pspdfkit.com/guides/android/)


# Native Channel Information

Their are two native channels implemented on each android & iOS.
- The first native channel passes data from Flutter to native to PSPDFKit SDK
- The second native channel passes data from PSPDFKit SDK to Native to Flutter

Refer to *lib/FlutterMethodChannel.dart* for all the methods that get data from native side for PSPDFKit Analytics.  
Refer to *lib/home/PDF_REDER/views/pdf_viewer.dart* for the native method call from flutter that opens the PSPDFKit Reader.   
Refer to *android/app/src/main/kotlin/notespedia/com/notespedia/NativeMethodChannel.kt* for method implementation that passes data from native to Flutter.

### Method implemented for PSPDFKit.

Channel Name = "native_pdf_implementation/pdfViewer"

- platform.invokeMethod("pdfViewer", \<Map\> data)
    - This method triggers the native channel implementation that opens the PSPDFKit Reader
    - The data required for the reader is passed as a Map. The data that is passed is given below
        - fileBytes
        - bookFilePath
        - bookId
        - isComplete
        - isFirstRead
        - isSecondRead
        - isFromPractice
        - bookName
        - isSeeSample
        - pdfLink (optional)
        - currentPage (optional)
        - startTime
        - user_info

### Methods called from native side for PSPDFKit Analytics.

Channel Name = "channel"

- "showNewIdea"
    - This method is used to save the last read page of the PDF.
    - The name of the method is given at random and has no significance.
    - The data recieved from native for this method is as given in the exact same order
        - currentPageNumber
        - bookId
        - total number of pages
- "markAsComplete"
    - This method marks the book as completed reading and sets the isComplete or isFirstRead or isSecondRead flags depending upon the instance
    - the data recieved from native for this method is as given in the exact same order
        - bookId
        - isFirstRead
        - isSecondRead
        - isComplete
- "insertUserReadingTime"
    - This method adds the users reading time to the analytics.
    - The following data is recieved from the native side for this method in the exact same order
        - bookId
        - startTime
        - bookFilePath
        - isComplete
        - bookName
        - current page number
        - isFirstRead
        - isFromPractice
        - isSecondRead
        - isSeeSample
        - total page count

## Native Channel Implementation of Android

The Android Counterpart for the native implementation has been done in *Kotlin*

Refer *android/app/src/main/kotlin/notespedia/com/notespedia/WebDownloadSource.kt* for PDF downloader used to download and display Samples pdf.

On android the Screenshot protection is implemented using ```getWindow().addFlags(LayoutParams.FLAG_SECURE);``` (It doesn't work on iOS).

On android the PSPDFKit is implemented using ```CustomPDFActivity``` which is an implementation of the class ```PDFActivity()```

The Following functions are implemented in the class.
- customTestDrawableProvider
    - This function draws the watermark of users UID on the PDF
- onDocumentLoaded
    - The custom configuration implemented is set for the document in this method ```thumbnailGrid.setDocument(document, this.configuration.configuration)```
- onBackPressed
    - This handles the closing of the PDFActivity
    - In this method we save the last used scrollDirection and Scroll Mode to be reused again on startup using shared Preferences
    - We also handle the displaying of Alert if the PDF is completed
- onPageChanged
    - This method saves the current page by calling the method "showNewIdea"
    - This method is triggered every time the page is changed
- askOption
    - This is the function that actually displays the alert dialogue box
    - With two options yes and no which each individually trigger different methods to either mark the book as completed and save analytics data or to just save the analytics data
- onCreate
    - This method is triggered whenever the PDFActivity is created
    - First we set the screenshot protection flags to secure using WindowManager
    - We enable the shared preferences
    - we initialise a custom thumbnail grid and button implementation
    - we register the drawable provider which will provide the drawable watermark to the PDFFragments
    - we also add the drawable on thumbnail bar and thumbnail grid
    - we also add the drawable then on the outline view as well
- initThumbnailGridAndButton
    - We initialise the thumbnail grid here and set export enabled to false

The WaterMarkDrawable class is directly copied from the PSPDFKit Documentation so you can refer it for more information.

## Native Channel Implementation of iOS

The Android Counterpart for the native implementation has been done in *Swift*

Document downloading and loading directly handled by PSPDFKit. The URL is passed in the ```Document(url: URL(String urlPath))```

The PSDPFKit Reader is implemented directly using ```PDFViewController```.    
To navigate back and forth between ```FlutterViewController``` and ```PDFViewController``` the ```FlutterViewController``` is embeded in a Native ```UINavigationController```.

Screenshot Protection for the PDF viewer is implemented using an Extension to the ```UIWindow```. The implementation for it is attached below.

```func pdfViewControllerDidDismiss(_ pdfController: PDFViewController)``` in iOS implements all the method channel calls for analytics same as Android and also alert dialogue with the same functionality as in Android.

```
let field = UITextField()

extension UIWindow {
    func initialiseSecurity(uiWindow: UIWindow) {
        field.isSecureTextEntry = false
        uiWindow.addSubview(field)
        field.centerYAnchor.constraint(equalTo: uiWindow.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: uiWindow.centerXAnchor).isActive = true
        uiWindow.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.first?.addSublayer(uiWindow.layer)
      }
}

func makeSecure() {
    field.isSecureTextEntry = true
}

func  removeSecure() {
    field.isSecureTextEntry = false
}
```

