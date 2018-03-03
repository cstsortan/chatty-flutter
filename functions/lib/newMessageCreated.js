"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
function onNewMessageCreated(event) {
    const userUid = event.params.userUid;
    const contactUid = event.params.contactUid;
    const messageId = event.params.messageId;
    const latestMessage = event.data.data();
    latestMessage.latestMessageTimestamp = Date.now();
    return admin.firestore()
        .doc(`privatechats/${userUid}/chats/${contactUid}`)
        .set(latestMessage, { merge: true });
}
exports.onNewMessageCreated = onNewMessageCreated;
//# sourceMappingURL=newMessageCreated.js.map