import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mustang_app/models/user.dart';

class DatabaseService {
  // collection reference
  static final CollectionReference users =
      Firestore.instance.collection('users');

  static String number;
  static String grade;
  static String skillLevel;

  static List<String> keys = new List();
  static List<String> values = new List();

  static Future<void> initUserData(User mainUser) async {
    // String name = (await getValueFromKey(user.email, 'name'));
    // print("NAME: " + name);
    // String email = await getValueFromKey(user.email, 'email') ?? "unknown";
    // String number = await getValueFromKey(user.email, 'number') ?? "unknown";
    // String skillLevel = await getValueFromKey(user.email, 'skillLevel') ?? "unknown";
    // String grade = await getValueFromKey(user.email, 'grade') ?? "9";
    await getUserData(mainUser.email);
    print("InitiatingUserData");
    print(keys);
    print(values);
    users.document(mainUser.email).setData({
      'name': values.elementAt(keys.indexOf("name")),
      'email': values.elementAt(keys.indexOf("email")),
      'number': values.elementAt(keys.indexOf("number")),
      'skillLevel': values.elementAt(keys.indexOf("skillLevel")),
      'grade': values.elementAt(keys.indexOf("grade"))
    });
  }

  static Future<void> updateUserData(User user) async {
    // String skillLevel = getValueFromKey(user.email, 'skillLevel') ?? user.skillLevel.toString();
    users.document(user.email).setData({
      'name': user.name,
      'email': user.email,
      'number': user.number,
      'skillLevel': user.skillLevel,
      'grade': user.grade
    });
  }

  static Future<void> registerUserData(User user) async {
    // String skillLevel = getValueFromKey(user.email, 'skillLevel') ?? user.skillLevel.toString();
    bool doesUserExist = await userExists(user.email);
    if (!doesUserExist) {
      users.document(user.email).setData({
        'name': user.name,
        'email': user.email,
        'number': user.number,
        'skillLevel': user.skillLevel,
        'grade': user.grade
      });
    }
  }

  static Future<String> getValueFromKey(String userEmail, String reqKey) async {
    QuerySnapshot data = await users.getDocuments();
    data.documents.forEach((f) {
      if (f.documentID == userEmail) {
        f.data.forEach((key, value) {
          if (key == reqKey) {
            print("VAL: " + value.toString() ?? "null");
            return value.toString();
          }
        });
      }
    });
  }

  static Future<String> getUserData(String userEmail) async {
    keys = new List();
    values = new List();
    QuerySnapshot data = await users.getDocuments();
    data.documents.forEach((f) {
      if (f.documentID == userEmail) {
        f.data.forEach((key, value) {
          keys.add(key);
          values.add(value);
        });
      }
    });
  }

  static Future<bool> userExists(String userEmail) async {
    keys = new List();
    values = new List();
    bool a = false;
    QuerySnapshot data = await users.getDocuments();
    data.documents.forEach((f) {
      print(f.documentID + " " + userEmail);
      if (f.documentID == userEmail) {
        a = true;
      }
    });
    return a;
  }

  static String getSkillLevel(String userEmail) {
    users.getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result['email'] == userEmail) {
          return result['skillLevel'];
        } else {
          return null;
        }
      });
    });
  }
}
