import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; // For lookupMimeType
import 'package:http_parser/http_parser.dart'; // For MediaType

class RFQService {
  static Future<Map<String, dynamic>> submitRFQ({
    required String email,
    required String fullName,
    required String mobileNo,
    required String companyName,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String country,
    required List<Map<String, dynamic>> parts,
    File? file, // Optional file
  }) async {
    final uri = Uri.parse('http://172.16.2.5:8080/semikartapi/submitRFQ');
    final request = http.MultipartRequest('POST', uri);

    // Add form fields
    request.fields['email'] = email;
    request.fields['fullName'] = fullName;
    request.fields['mobileNo'] = mobileNo;
    request.fields['companyName'] = companyName;
    request.fields['address'] = address;
    request.fields['city'] = city;
    request.fields['state'] = state;
    request.fields['pinCode'] = pinCode;
    request.fields['country'] = country;
    request.fields['parts'] = jsonEncode(parts); // Encode parts list to JSON string

    // Add file if provided
    if (file != null) {
      final mimeType = lookupMimeType(file.path);
      String? mainType;
      String? subType;

      if (mimeType != null) {
        final parts = mimeType.split('/');
        if (parts.length == 2) {
          mainType = parts[0];
          subType = parts[1];
        }
      }
      
      request.files.add(
        await http.MultipartFile.fromPath(
          'File', // API expects the file under this key
          file.path,
          contentType: (mainType != null && subType != null) 
              ? MediaType(mainType, subType) 
              : null, // Let http decide if mimeType is unknown
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // You might want to check responseData['status'] == 'success' here
        return responseData;
      } else {
        // Attempt to parse error message if available
        String errorMessage = 'Failed to submit RFQ. Status code: ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['message'] != null) {
            errorMessage = errorData['message'];
          } else {
            errorMessage += ' - ${response.body}';
          }
        } catch (e) {
          // If body is not JSON or message field is not present
           errorMessage += ' - ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Error submitting RFQ: ${e.toString()}');
    }
  }
}
