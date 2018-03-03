import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase);
import { onUserCreated } from './newUserCreated'
import { createFirUserRequest } from './createFirUserRequest';
import { onNewMessageCreated } from './newMessageCreated';
import { onUserDeleted } from './userDeleted';

// Called every time a user is being created with firebase auth
export const userCreated = functions.auth.user()
    .onCreate(onUserCreated)

// Called every time a user is being deleted
// And marks the user accound as deleted with
// an isDeleted flag and a deletionTimestamp.
export const userDeleted = functions.auth.user()
    .onDelete(onUserDeleted);


// // Will delete when user migration is done
// export const createFirUser = functions.https
//     .onRequest(createFirUserRequest)


// This will make populating the Recent chats page easier
// By simply listenning at privateChats/${userUid}/chats collection
// Where there is one document for each contact they've recently chatted with,
// and includes the latest text message and the timestamp
export const newMessageCreated = functions.firestore
    .document('privatechats/{userUid}/chats/{contactUid}/messages/{messageId}')
    .onCreate(onNewMessageCreated);
