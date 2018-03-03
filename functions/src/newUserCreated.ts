import {Event} from 'firebase-functions'
import {UserRecord} from 'firebase-functions/lib/providers/auth'
import * as admin from 'firebase-admin'
import {User} from './models/user'

const usersCol = admin
    .firestore()
    .collection('users')

// This function is being called every time a new user is being created with
// firebase auth.
export function onUserCreated(event : Event < UserRecord >) {
    return Promise.all([
        createUserRecord(event.data),
        // hitServerApi(event.data, event.timestamp)
    ])
}

export function createUserRecord(firUser : UserRecord) : Promise < void > {
    return usersCol
        .doc(firUser.uid)
        .set({
            userUid: firUser.uid
        }, {merge: true})
        .then(res => {
            console.log(`document created for new user: ${firUser.uid}`)
        })
        .catch(error => {
            console.error(error)
        })
}

function hitServerApi(firUser : UserRecord, timestamp : string) : Promise < void > {
    // TODO implementation Making http trigger to inform the server that a new user
    // has been created.
    return new Promise(null)
}