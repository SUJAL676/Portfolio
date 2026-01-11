import 'package:url_launcher/url_launcher.dart';

class Resumedownload {
  Future<void> downloadResume() async {
    const String resumeUrl =
        'https://drive.google.com/uc?export=download&id=1yZsjowL-fJ3Wi0x6ifBIpEassa87Uwpv';

    final Uri uri = Uri.parse(resumeUrl);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // important for web
    )) {
      throw 'Could not download resume';
    }
  }
}
