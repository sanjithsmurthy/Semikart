const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// Create a document in Firestore when a new user is created in Authentication
exports.createUserDocument = functions.auth.user().onCreate(async (user) => {
  const db = admin.firestore();
  const userDocRef = db.collection('users').doc(user.uid);

  // Prepare the initial user data
  const userData = {
    uid: user.uid,
    email: user.email, // From Auth
    displayName: user.displayName || '', // From Auth (might be null)
    photoURL: user.photoURL || null, // From Auth (might be null)
    emailVerified: user.emailVerified, // From Auth
    phoneNumber: user.phoneNumber || null, // From Auth (might be null)

    // App-specific fields with defaults
    firstName: '', // Will be updated by app later
    lastName: '', // Will be updated by app later
    companyName: '', // Will be updated by app later
    altPhoneNumber: '', // Will be updated by app later
    gstin: '', // Will be updated by app later
    userType: '', // Will be updated by app later
    leadSource: 'Direct Auth', // Default source
    sendOrderEmails: true, // Default preference

    // Timestamps
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    lastLoginAt: admin.firestore.FieldValue.serverTimestamp(), // Set initial login time
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Extract first/last name from displayName if available and names are empty
  if (!userData.firstName && !userData.lastName && userData.displayName) {
    const nameParts = userData.displayName.split(' ').filter(part => part.length > 0);
    if (nameParts.length > 0) {
      userData.firstName = nameParts[0];
      if (nameParts.length > 1) {
        userData.lastName = nameParts.slice(1).join(' ');
      }
    }
  }

  try {
    await userDocRef.set(userData);
    console.log(`Successfully created Firestore document for user: ${user.uid}`);
  } catch (error) {
    console.error(`Error creating Firestore document for user ${user.uid}:`, error);
    // Handle the error appropriately
  }
  return null; // Important to return null or a promise
});

// Update the Firestore document when the *Firebase Auth* user record is updated
exports.updateUserDocument = functions.auth.user().onUpdate(async (change) => {
  const db = admin.firestore();
  const userAfter = change.after; // The updated user record from Auth
  const userBefore = change.before; // The previous user record from Auth
  const userDocRef = db.collection('users').doc(userAfter.uid);

  // Prepare data to update based *only* on changes in the Auth record
  const dataToUpdate = {};

  if (userAfter.email !== userBefore.email) {
    dataToUpdate.email = userAfter.email;
  }
  if (userAfter.displayName !== userBefore.displayName) {
    dataToUpdate.displayName = userAfter.displayName || ''; // Handle null
     // Optionally update firstName/lastName if they are derived from displayName
     // and haven't been explicitly set by the user in the app.
     // This logic can be complex, decide if it's needed.
     // Example (simple split, might overwrite user edits):
     // const nameParts = (userAfter.displayName || '').split(' ').filter(part => part.length > 0);
     // dataToUpdate.firstName = nameParts[0] || '';
     // dataToUpdate.lastName = nameParts.length > 1 ? nameParts.slice(1).join(' ') : '';
  }
  if (userAfter.photoURL !== userBefore.photoURL) {
    dataToUpdate.photoURL = userAfter.photoURL || null; // Handle null
  }
  if (userAfter.emailVerified !== userBefore.emailVerified) {
    dataToUpdate.emailVerified = userAfter.emailVerified;
  }
  if (userAfter.phoneNumber !== userBefore.phoneNumber) {
    dataToUpdate.phoneNumber = userAfter.phoneNumber || null; // Handle null
  }

  // Only update if there are actual changes from Auth
  if (Object.keys(dataToUpdate).length > 0) {
    dataToUpdate.updatedAt = admin.firestore.FieldValue.serverTimestamp(); // Add timestamp for any Auth update

    try {
      await userDocRef.update(dataToUpdate);
      console.log(`Successfully updated Firestore document for user ${userAfter.uid} based on Auth changes.`);
    } catch (error) {
      console.error(`Error updating Firestore document for user ${userAfter.uid} based on Auth changes:`, error);
      // Handle the error appropriately
    }
  } else {
     console.log(`No relevant Auth changes detected for user ${userAfter.uid}. Firestore document not updated by this function.`);
  }

  return null;
});

// Optional: Handle user deletion in Authentication
exports.deleteUserDocument = functions.auth.user().onDelete(async (user) => {
  const db = admin.firestore();
  const userDocRef = db.collection('users').doc(user.uid);

  try {
    await userDocRef.delete();
    console.log(`Successfully deleted Firestore document for user: ${user.uid}`);
  } catch (error) {
    console.error(`Error deleting Firestore document for user ${user.uid}:`, error);
    // Handle the error appropriately
  }
  return null;
});