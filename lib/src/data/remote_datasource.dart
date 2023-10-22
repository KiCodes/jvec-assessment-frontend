import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
final client = http.Client();


const String baseUrl = "http://10.0.2.2:8000";

class DataSource {
  static Future<Map> signUp(String firstName, String lastName,
      String phoneNumber, String email, String password) async {
    // returns {"message": "User registered successfully"} on success
    // returns { message: "Email already exists" } on failure
    // returns { message: "Phone number already exists" } on failure
    const Duration timeoutDuration = Duration(seconds: 15);
    String postUrl = "/api/signup";
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
    };
    try {
      var response = await client
          .post(Uri.parse(baseUrl + postUrl), body: body)
          .timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });
      return jsonDecode(response.body);
    } catch (e) {
      if (e is TimeoutException) {
        return {"status": "fail", "message": 'Request timed out'};
      } else {
        return {"status": "fail", "message": e};
      }
    }
  }

  static Future<Map> login(String email, String password) async {
    // returns {"token": ...} on success
    // returns {"message": ...} on failure
    const Duration timeoutDuration = Duration(seconds: 15);

    String postUrl = "/api/login";
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    try {
      var response = await client
          .post(Uri.parse(baseUrl + postUrl), body: body)
          .timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });
      if (response.statusCode == 200) {
        // Successful login
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {
          "status": "fail",
          "message": "Login failed. Please check your credentials."
        };
      }
    } catch (e) {
      if (e is TimeoutException) {
        return {"status": "fail", "message": 'Request timed out'};
      } else {
        return {"status": "fail", "message": e};
      }
    }
  }

  static Future<Map<String, String>> logout(String token) async {
    //{"message": } on success
    const Duration timeoutDuration = Duration(seconds: 15);

    String postUrl = "/api/logout";

    try {
      var response = await client.post(
        Uri.parse(baseUrl + postUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token,
        },
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 200) {
        // Successful logout
        Map<String, String> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {"status": "fail", "message": "Logout failed"};
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong');
      }
    }
  }

  static Future<Map<String, dynamic>> addContact(
      String token, String firstName, String lastName, String phoneNumber) async {
    // { message: "User not found" } on failure
    //    { message: "Contact saved successfully", contact: newContact }
    const Duration timeoutDuration = Duration(seconds: 15);

    String postUrl = "/api/contact-add";
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
    };

    try {
      var response = await client.post(
        Uri.parse(baseUrl + postUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token,
        },
        body: jsonEncode(body),
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 201) {
        // Contact saved successfully
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {"status": "fail", "message": "Error saving contact"};
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong, $e');
      }
    }
  }

  static Future<List<dynamic>> searchContacts(
      String token, String query) async {
    const Duration timeoutDuration = Duration(seconds: 15);

    String getUrl = "/api/contacts-search?query=$query";

    try {
      var response = await client.get(
        Uri.parse(baseUrl + getUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token,
        },
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 200) {
        // Contacts found successfully
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return [];
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong, $e');
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getAllContacts(String? token) async {
    //{"contacts": list} on success
    //{"message": "error fetching contacts"} on failure
    const Duration timeoutDuration = Duration(seconds: 15);

    String getUrl = "/api/contact-all";

    try {
      var response = await client.get(
        Uri.parse(baseUrl + getUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token!,
        },
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 200) {
        // Successful request, return the list of contacts
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<Map<String, dynamic>> contacts =
        List<Map<String, dynamic>>.from(jsonResponse['contacts']);
        return contacts;
      } else {
        // Return an empty list or handle the error as needed
        return [];
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong, $e');
      }
    }
  }

  static Future<Map<String, dynamic>> updateContact(
      String token, String contactId, Map<String, dynamic> updateData) async {
    const Duration timeoutDuration = Duration(seconds: 15);

    String putUrl = "/api/contact-update/$contactId";

    try {
      var response = await client.put(
        Uri.parse(baseUrl + putUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token,
        },
        body: jsonEncode(updateData),
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 200) {
        // Contact updated successfully
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {'message': 'error updating contact, ${response.body}'};
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong, $e');
      }
    }
  }

  static Future<Map<String, dynamic>> deleteContact(
      String token, String contactId) async {
    const Duration timeoutDuration = Duration(seconds: 15);

    String deleteUrl = "/api/contact-delete/$contactId";

    try {
      var response = await client.delete(
        Uri.parse(baseUrl + deleteUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token,
        },
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 200) {
        // Contact deleted successfully
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {};
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong');
      }
    }
  }

  static Future<Map<String, dynamic>> getUserDetails(String token) async {
    const Duration timeoutDuration = Duration(seconds: 15);

    String getUrl = "/api/user-details";

    try {
      var response = await client.get(
        Uri.parse(baseUrl + getUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': token,
        },
      ).timeout(timeoutDuration, onTimeout: () {
        throw TimeoutException('The request timed out');
      });

      if (response.statusCode == 200) {
        // User details retrieved successfully
        Map<String, dynamic> userDetails = jsonDecode(response.body);
        return userDetails;
      } else {
        return {};
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out');
      } else {
        throw Exception('Something went wrong, $e');
      }
    }
  }

}