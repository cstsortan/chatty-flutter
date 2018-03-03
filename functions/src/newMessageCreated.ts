import { Event } from "firebase-functions";
import { DeltaDocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import * as admin from 'firebase-admin';

export function onNewMessageCreated(event: Event<DeltaDocumentSnapshot>) {
    const userUid: string = event.params.userUid;
    const contactUid: string = event.params.contactUid;
    const messageId: string = event.params.messageId;

    const latestMessage = event.data.data();
    latestMessage.latestMessageTimestamp = Date.now();

    return admin.firestore()
        .doc(`privatechats/${userUid}/chats/${contactUid}`)
        .set(latestMessage, {merge: true});
}