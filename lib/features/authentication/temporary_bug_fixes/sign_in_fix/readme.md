Bug: [firebase_auth] signInWithEmailAndPassword returns error code "unknown"
https://github.com/firebase/flutterfire/issues/10966


Temporary Fix:
Use the parseFirebaseAuthExceptionMessage function
It is a regex that will extract the code of a FirebaseAuthException from the exception message: