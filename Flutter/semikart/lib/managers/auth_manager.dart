import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In

// --- Authentication Status Enum ---
enum AuthStatus { unknown, authenticated, unauthenticated }

// --- Authentication State Class ---
class AuthState {
  final AuthStatus status;
  final User? user; // Firebase user object
  final String? errorMessage; // Optional error message

  AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
  });

  // Helper method to create a copy with updated values
  AuthState copyWith({
    AuthStatus? status,
    User? user, // Allow setting user to null
    String? errorMessage,
    bool clearError = false, // Flag to explicitly clear error
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user, // Directly assign the new user value
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}


// --- Firebase Authentication Service ---
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Add GoogleSignIn instance

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // --- ActionCodeSettings (Configure this carefully!) ---
  // You MUST configure either Firebase Dynamic Links or Custom URL Schemes
  // for this to work correctly. Replace placeholders with your actual config.
  ActionCodeSettings _getActionCodeSettings() {
    return ActionCodeSettings(
      // URL you want to redirect back to. The domain (e.g., semikart.page.link)
      // MUST be whitelisted in the Firebase Console -> Authentication -> Settings -> Authorized domains.
      url: 'https://semikart.page.link/finishSignUp', // Example using Dynamic Links
      // This must be true for email link sign-in on mobile apps.
      handleCodeInApp: true,
      iOSBundleId: 'com.example.semikart', // Replace with your iOS bundle ID
      androidPackageName: 'com.example.semikart', // Replace with your Android package name
      // Install the Android app if it's not already installed?
      androidInstallApp: true,
      // Minimum Android version?
      androidMinimumVersion: '12',
    );
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      log("Firebase signup successful for: ${cred.user?.email}");
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("Firebase signup error: ${e.code} - ${e.message}");
      rethrow; // Rethrow to be caught by AuthManager
    } catch (e) {
      log("An unexpected error occurred during signup: $e");
      rethrow; // Rethrow generic error
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      log("Firebase login successful for: ${cred.user?.email}");
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("Firebase login error: ${e.code} - ${e.message}");
      rethrow; // Rethrow to be caught by AuthManager
    } catch (e) {
      log("An unexpected error occurred during login: $e");
      rethrow; // Rethrow generic error
    }
  }

  Future<void> signout() async {
    try {
      await _googleSignIn.signOut(); // Sign out from Google
      await _auth.signOut();
      log("Firebase & Google signout successful.");
    } catch (e) {
      log("An error occurred during signout: $e");
      rethrow; // Rethrow to be caught by AuthManager
    }
  }

  // --- Google Sign-In Implementation ---
  Future<User?> signInWithGoogle() async {
    log("Attempting Google Sign-In...");
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log("Google Sign-In cancelled by user.");
        return null; // User cancelled
      }
      log("Google user obtained: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      log("Google authentication tokens obtained.");

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      log("Firebase OAuth credential created.");

      final userCredential = await _auth.signInWithCredential(credential);
      log("Firebase Sign-In with Google credential successful for: ${userCredential.user?.email}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
       log("Firebase Google Sign-In error: ${e.code} - ${e.message}");
       rethrow;
    } catch (e) {
      log("Google Sign-In error: $e");
      rethrow;
    }
  }

  // --- Email Link Sign-in Methods ---
  Future<void> sendSignInLinkToEmail(String email) async {
    var acs = _getActionCodeSettings();
    try {
      await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: acs);
      log("Sign-in link sent to $email");
      // IMPORTANT: You need to save the email locally (e.g., using SharedPreferences)
      // because you'll need it again when the user clicks the link and returns to the app.
      // Example: await _saveEmailForSignIn(email);
    } on FirebaseAuthException catch (e) {
      log("Error sending sign-in link: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      log("An unexpected error occurred sending the sign-in link: $e");
      rethrow;
    }
  }

  // Check if an incoming link is a sign-in link
  bool isSignInWithEmailLink(String link) {
    return _auth.isSignInWithEmailLink(link);
  }

  // Sign in with the email link
  Future<User?> signInWithEmailLink(String email, String link) async {
    try {
      final userCredential = await _auth.signInWithEmailLink(email: email, emailLink: link);
      log("Successfully signed in with email link for: ${userCredential.user?.email}");
      // IMPORTANT: Clear the saved email after successful sign-in.
      // Example: await _clearSavedEmail();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("Error signing in with email link: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      log("An unexpected error occurred signing in with the email link: $e");
      rethrow;
    }
  }

  // --- Placeholder for saving/retrieving email ---
  // You'll need to implement this using a storage solution like shared_preferences
  // Future<void> _saveEmailForSignIn(String email) async { /* ... */ }
  // Future<String?> _getSavedEmail() async { /* ... */ }
  // Future<void> _clearSavedEmail() async { /* ... */ }

  // --- Password Reset ---
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      log("Password reset email sent to: $email");
    } on FirebaseAuthException catch (e) {
      log("Error sending password reset email: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      log("An unexpected error occurred sending password reset email: $e");
      rethrow;
    }
  }

  // --- Phone Auth (Placeholders - Requires implementation if needed) ---
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 60),
  }) async {
     log("Phone verification not fully implemented in AuthService.");
     // Add Firebase phone verification logic here if needed
     try {
       await _auth.verifyPhoneNumber(
         phoneNumber: phoneNumber,
         verificationCompleted: verificationCompleted,
         verificationFailed: verificationFailed,
         codeSent: codeSent,
         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
         timeout: timeout,
       );
     } on FirebaseAuthException catch (e) {
        log("Error initiating phone verification: ${e.code} - ${e.message}");
        verificationFailed(e);
     } catch(e) {
        log("Unexpected error during phone verification initiation: $e");
        // Consider calling verificationFailed with a generic exception
     }
  }

  Future<User?> signInWithPhoneCredential(PhoneAuthCredential credential) async {
     log("Phone credential sign-in not fully implemented in AuthService.");
     // Add Firebase phone sign-in logic here if needed
     try {
       final userCredential = await _auth.signInWithCredential(credential);
       log("Phone credential sign-in successful for: ${userCredential.user?.phoneNumber}");
       return userCredential.user;
     } on FirebaseAuthException catch (e) {
       log("Phone credential sign-in error: ${e.code} - ${e.message}");
       rethrow;
     } catch (e) {
       log("An unexpected error occurred during phone credential sign-in: $e");
       return null;
     }
  }
}


// --- Riverpod Providers ---

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// --- Auth Manager (State Notifier) ---
class AuthManager extends StateNotifier<AuthState> {
  final AuthService _authService;
  StreamSubscription<User?>? _authStateSubscription;

  AuthManager(this._authService) : super(AuthState()) {
    _initialize();
  }

  void _initialize() {
    // Immediately check current user state
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      log("AuthManager Init: User found - ${currentUser.uid}");
      state = AuthState(status: AuthStatus.authenticated, user: currentUser);
    } else {
      log("AuthManager Init: No user found.");
      state = AuthState(status: AuthStatus.unauthenticated);
    }

    // Listen to future auth state changes
    _authStateSubscription = _authService.authStateChanges.listen((user) {
       log("Auth State Changed Listener: User ${user?.uid}, Status: ${user != null ? 'Authenticated' : 'Unauthenticated'}"); // <-- Add log
      if (user != null) {
        state = state.copyWith(status: AuthStatus.authenticated, user: user, clearError: true);
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null, clearError: true); // Clear user on logout
      }
    }, onError: (error) {
       log("Auth State Stream Error: $error");
       state = state.copyWith(status: AuthStatus.unauthenticated, user: null, errorMessage: "An error occurred.");
    });
  }

  Future<bool> login(String email, String password) async {
    try {
      final user = await _authService.loginUserWithEmailAndPassword(email, password);
      // State update handled by the stream listener
      return user != null;
    } catch (e) {
      log("AuthManager Login Error: $e");
      state = state.copyWith(errorMessage: _handleAuthError(e), status: AuthStatus.unauthenticated);
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String displayName) async {
     // Note: Firebase createUser does not directly take displayName.
     // You might need to update the user profile *after* creation.
    try {
      final user = await _authService.createUserWithEmailAndPassword(email, password);
      if (user != null) {
        log("AuthManager SignUp: User created successfully (${user.uid}). Waiting for authStateChanges listener."); // <-- Add log
        // Optionally update display name here if needed
        // await user.updateDisplayName(displayName);
        // State update handled by the stream listener
        return true;
      }
      return false;
    } catch (e) {
      log("AuthManager SignUp Error: $e");
      state = state.copyWith(errorMessage: _handleAuthError(e), status: AuthStatus.unauthenticated);
      return false;
    }
  }

   Future<bool> googleSignIn() async {
    try {
      final user = await _authService.signInWithGoogle();
      // State update handled by the stream listener
      return user != null;
    } catch (e) {
      log("AuthManager Google Sign-In Error: $e");
      state = state.copyWith(errorMessage: _handleAuthError(e), status: AuthStatus.unauthenticated);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signout();
      // State update handled by the stream listener
    } catch (e) {
      log("AuthManager Logout Error: $e");
      // Optionally set an error message, though usually not needed for logout
      state = state.copyWith(errorMessage: "Logout failed.", status: AuthStatus.authenticated); // Stay authenticated if logout fails? Or force unauth?
    }
  }

   Future<bool> sendPasswordReset(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      log("AuthManager Password Reset Error: $e");
      state = state.copyWith(errorMessage: _handleAuthError(e)); // Keep current auth status
      return false;
    }
  }

  // Helper to convert Firebase exceptions to user-friendly messages
  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'email-already-in-use':
           return 'An account already exists for that email.';
        case 'weak-password':
           return 'The password provided is too weak.';
        case 'network-request-failed':
           return 'Network error. Please check your connection.';
        // Add more specific cases as needed
        default:
          log("Unhandled FirebaseAuthException code: ${error.code}");
          return 'An authentication error occurred. Please try again.';
      }
    }
    // Handle Google Sign-In specific errors if necessary (e.g., PlatformException)
    return 'An unexpected error occurred. Please try again.';
  }


  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}

// --- StateNotifierProvider for AuthManager ---
final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthManager(authService);
});


// --- Deprecated Provider (kept for reference, should be removed/replaced) ---
// This StreamProvider is now less useful as AuthManager handles the state.
// Widgets should watch `authManagerProvider` instead.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

