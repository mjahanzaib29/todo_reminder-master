import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

import 'package:todo_reminder/Util/sharedprefs.dart';
import 'package:todo_reminder/model/categoryinfo.dart';
import 'package:todo_reminder/model/todoinfo.dart';

class NetworkHandler {
  var resbody, code, token, taskres;

  Future loginUser(Map<String, String> body) async {
    var url =
        Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/login');
    var response = await http.post(url, body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      token = output['token'];
      await MySharedPreferences.instance
          .setStringValue("token", output['token']);
      print(MySharedPreferences.instance.getStringValue("token"));
      print(output['token']);
      return output['message'];
    }
    {
      print("statusccod is not 200");
      print(response.body);
      return output['error'];
    }
  }

  //Add Task Via token auth
  Future<dynamic> insertTasks(Map<dynamic, dynamic> body) async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url =
        Uri.parse('https://rocky-brushlands-19286.herokuapp.com/todo/store');
    var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }
      print(response.body + response.statusCode.toString());
      return output['message'];
    }
  }

  Future<dynamic> EditTask(Map<dynamic, dynamic> body) async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url =
    Uri.parse('https://rocky-brushlands-19286.herokuapp.com/todo/store');
    var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }
      print(response.body + response.statusCode.toString());
      return output['message'];
    }
  }

  //Fetch Categoris Via token
  Future<Welcome> getcategory() async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url = Uri.parse(
        'https://rocky-brushlands-19286.herokuapp.com/todo/category/list');
    var result = null;
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var output = convert.jsonDecode(response.body);
      print(output);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = Welcome.fromJson(output);
        print("complete output");
        print(output);
        print(result);
        return result;
      }
    } catch (Exception) {
      return result;
    }
    return result;
  }

  //for drpdownlist
  Future<Welcome> getcategoryfordropdown() async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url = Uri.parse(
        'https://rocky-brushlands-19286.herokuapp.com/todo/category/list');
    var result = null;
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var output = convert.jsonDecode(response.body);
      print(output);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = Welcome.fromJson(output);
        print("complete output");
        print(output);
        print(result);
        return result.todos;
      }
    } catch (Exception) {
      return result;
    }
    return result;
  }

  //Get todolist
  Future<TodoInfo> getTodolist() async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url =
        Uri.parse('https://rocky-brushlands-19286.herokuapp.com/todo/list');
    var result = null;
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var output = convert.jsonDecode(response.body);
      print(output);
      if (response.statusCode == 200 || response.statusCode == 201) {
        result = TodoInfo.fromJson(output);
        print("complete todolist");
        print(output);
        print(result);
        return result;
      }
    } catch (Exception) {
      return result;
    }
    return result;
  }

  //Register new User
  Future<dynamic> register(Map<String, String> body) async {
    var url =
        Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/signup');
    var response = await http.post(url, body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      return output['message'];
    }
    {
      print("statusccod is not 200");
      print(response.body);
      return output['error'];
    }
  }
 //Sending firebase messaging token to postman
  Future<dynamic> FCMToken(Map<String, String> body) async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url = Uri.parse(
        'https://rocky-brushlands-19286.herokuapp.com/todo/token/update');
    var response = await http.put(url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      print("Token sended");
      return output['message'];
    }
    {
      print("statuscode is not 200");
      print(response.body);
      return output['error'];
    }
  }

  // Add category
  Future<dynamic> addCategory(Map<String, String> body) async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url = Uri.parse(
        'https://rocky-brushlands-19286.herokuapp.com/todo/category/store');
    var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      print("New Categry Added");
      return output['message'];
    }
    {
      print("statuscode is not 200");
      print(response.body);
      return output['error'];
    }
  }
}
