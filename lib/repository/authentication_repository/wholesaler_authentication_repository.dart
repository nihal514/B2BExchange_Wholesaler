import 'package:b2b_exchange_development_version/exceptions/wholesaler_login_email_password_failure.dart';
import 'package:b2b_exchange_development_version/exceptions/wholesaler_signup_email_password_failure.dart';
import 'package:b2b_exchange_development_version/features/entry_point/screens/welcome/weolcome_screen.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/wholesaler_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WAuthenticationRepository extends GetxController {
  static WAuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  // Will be load when app launches this func will be called and set the firebaseWholesaler state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  //
  // /// If we are setting initial screen from here
  // /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? wholesaler) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    wholesaler == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const WholesalerHome());
  }

  //FUNC

  Future<void> wPhoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "The provided phone number is not valid.");
        } else {
          Get.snackbar("Error", "Something went wrong. Try again.");
        }
      },
    );
  }

  //this function is called from the otp_controller
  Future<bool> wVerifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<String?> createWholesalerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // firebaseWholesaler.value != null ? Get.offAll(() => const DashboardScreen())
      //     : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = WSignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = WSignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> wLoginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = WLoginWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = WLoginWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> wLogOut() async => await _auth.signOut();

  //google signin/signup
  Future<String?> wSignInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleWholesaler =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleWholesaler!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // signin
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = WLoginWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = WLoginWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }
}
