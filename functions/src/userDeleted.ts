import { Event } from "firebase-functions";
import { UserRecord } from "firebase-functions/lib/providers/auth";
import * as admin from 'firebase-admin';

export function onUserDeleted(event: Event<UserRecord>) {


    const userUid = event.data.uid;
    
    // Simply mark the user as deleted
    return admin.firestore().doc(`users/${userUid}`)
        .set({
            isDeleted: true,
            deletionTimestamp: Date.now(),
        }, {merge: true});
}