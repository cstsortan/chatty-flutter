"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const usersCol = admin
    .firestore()
    .collection('users');
// This function is being called every time a new user is being created with
// firebase auth.
function onUserCreated(event) {
    return Promise.all([
        createUserRecord(event.data),
    ]);
}
exports.onUserCreated = onUserCreated;
function createUserRecord(firUser) {
    return usersCol
        .doc(firUser.uid)
        .set({
        userUid: firUser.uid
    }, { merge: true })
        .then(res => {
        console.log(`document created for new user: ${firUser.uid}`);
    })
        .catch(error => {
        console.error(error);
    });
}
exports.createUserRecord = createUserRecord;
function hitServerApi(firUser, timestamp) {
    // TODO implementation Making http trigger to inform the server that a new user
    // has been created.
    return new Promise(null);
}
//# sourceMappingURL=newUserCreated.js.map