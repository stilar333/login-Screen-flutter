import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class GetLogin {

  Future<bool> getAccess(String username, String password) async {

HttpClient httpClient = HttpClient();
httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;


HttpClientRequest request = await httpClient.getUrl(
  Uri.parse('https://srv426423.hstgr.cloud:3000/accounts/login/'+username));
 request.headers.set('content-type','application/json; charset=UTF-8');
HttpClientResponse response = await request.close();
print(response.statusCode);
String reply = await response.transform(utf8.decoder).join();
print(reply);
print(json.decode(reply)[0]['password']);
if(response.statusCode == 200){

  if(json.decode(reply)[0]['password'] == password){
    return true;
  } else {
    return false;
  }
 
} else {
return false;

} 
          
  }
}