"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);
const newUserCreated_1 = require("./newUserCreated");
const newMessageCreated_1 = require("./newMessageCreated");
const userDeleted_1 = require("./userDeleted");
// Called every time a user is being created with firebase auth
exports.userCreated = functions.auth.user()
    .onCreate(newUserCreated_1.onUserCreated);
// Called every time a user is being deleted
// And marks the user accound as deleted with
// an isDeleted flag and a deletionTimestamp.
exports.userDeleted = functions.auth.user()
    .onDelete(userDeleted_1.onUserDeleted);
// // Will delete when user migration is done
// export const createFirUser = functions.https
//     .onRequest(createFirUserRequest)
// This will make populating the Recent chats page easier
// By simply listenning at privateChats/${userUid}/chats collection
// Where there is one document for each contact they've recently chatted with,
// and includes the latest text message and the timestamp
exports.newMessageCreated = functions.firestore
    .document('privatechats/{userUid}/chats/{contactUid}/messages/{messageId}')
    .onCreate(newMessageCreated_1.onNewMessageCreated);
//# sourceMappingURL=index.js.map