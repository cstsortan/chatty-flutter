"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
function onUserDeleted(event) {
    const userUid = event.data.uid;
    // Simply mark the user as deleted
    return admin.firestore().doc(`users/${userUid}`)
        .set({
        isDeleted: true,
        deletionTimestamp: Date.now(),
    }, { merge: true });
}
exports.onUserDeleted = onUserDeleted;
//# sourceMappingURL=userDeleted.js.map