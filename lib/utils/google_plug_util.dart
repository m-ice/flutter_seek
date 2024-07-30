import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_d0601/utils/toast_util.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/utils/log_util.dart';

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  // clientId: ,
  // serverClientId: ,
  scopes: scopes,
);
class GooglePlugUtil{

  static GoogleSignInAccount? currentUser;
  static bool isAuthorized = false; // has granted permissions?
  static String contactText = '';

  static googleAuthListen(){
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      currentUser = account;
      isAuthorized = isAuthorized;
      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
      LogUtil.logUtil("Google监听事件：$isAuthorized ${account!.email}",tag: "${Constants.appTitle}_Google登录");

    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.cn/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  static Future<void> _handleGetContact(GoogleSignInAccount user) async {
    contactText = 'Loading contact info...';
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      contactText = 'People API gave a ${response.statusCode} '
          'response. Check logs for details.';
      LogUtil.logInfo('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      contactText = 'I see you know $namedContact!';
    } else {
      contactText = 'No contacts to display.';
    }

  }
  static String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      LogUtil.logInfo(error,level: Level.error);
    }
  }

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  // static Future<void> _handleAuthorizeScopes() async {
  //   final bool isAuthor = await _googleSignIn.requestScopes(scopes);
  //   isAuthorized = isAuthor;
  //   if (isAuthorized) {
  //     unawaited(_handleGetContact(currentUser!));
  //   }
  // }

  static Future<void> _handleSignOut() => _googleSignIn.disconnect();

  static void signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      LogUtil.logUtil("accessToken:${googleAuth.accessToken} idToken:${googleAuth.idToken}",tag: "${Constants.appTitle}_Google登录");
      // final AuthCredential credential = GoogleAuthProvider.getCredential(
      //   accessToken: googleAuth.accessToken,idToken: googleAuth.idToken,);
      // final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      // assert(user.email != null);
      // assert(user.displayName != null);
      // assert(!user.isAnonymous);
      // assert(await user.getIdToken() != null);
      // IdTokenResult idTokenResult = await user.getIdToken(refresh: true);
      // idToken = idTokenResult.token;
    }catch(error){
      LogUtil.logInfo(error,level: Level.error);
      toast('Auth error !');
    }
  }
}