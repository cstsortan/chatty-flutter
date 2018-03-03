import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import * as secureCompare from 'secure-compare';
import { createUserRecord } from './newUserCreated';
import { LegacyUser, User } from './models/user';

const usersCol = admin
    .firestore()
    .collection('users')

export async function createFirUserRequest(req: functions.Request, res: functions.Response, ) {
    const data: LegacyUser = req.body;

    // Secure key to authorize function trigger
    const key: string = req.query.key;

    // Exit if the keys don't match
    if (!secureCompare(key, functions.config().cron.key)) {
        console.log('The key provided in the request does not match the key set in the environment. Check that', key,
            'matches the cron.key attribute in `firebase env:get`');
        res.status(403).send('Security key does not match. Make sure your "key" URL query parameter matches the ' +
            'cron.key environment variable.');
        return null;
    }

    console.log(`Creating account for ${data.email}`)
    if (req.method !== 'POST') {
        console.log('is not POST');
        return res
            .status(404)
            .send({ error: "Use a POST request passing the email and pass" });
    }
    if (!data.email || !data.password) {
        console.log('no email or pass');
        return res
            .status(404)
            .send({ error: "Can't create a user with null email or pass" });
    }
    try {
        const user = await createUser(data);
        await passUserDataToDoc(user.uid, data);
        return res
            .status(200)
            .send({ result: `Created firebase user with uid: ${user.uid} and soon there should be a firestore document populated for that user by the cloud function`, user });
    } catch (error) {
        console.error(error);
        return res
            .sendStatus(404)
            .send({ error: `Error creating user: ${error}` });
    }
}

async function createUser(data: LegacyUser): Promise<admin.auth.UserRecord> {
    const { email, password, first_name, last_name, mobile_no } = data;
    const firUser = await admin
        .auth()
        .createUser({ email: email, password: password, displayName: `${last_name} ${first_name}` });
    return firUser;
}

async function passUserDataToDoc(userUid: string, data: LegacyUser): Promise<void> {
    const {
        first_name,
        last_name,
        mobile_no,
        address,
        city,
        postal_code,
        company
    } = data;

    try {
        const writeResult = await usersCol
            .doc(userUid)
            .set({
                first_name: first_name,
                last_name: last_name,
                mobile_no: mobile_no,
                address: address,
                city: city,
                postal_code: postal_code,
                company: company
            }, {
                    merge: true
                }, );
    } catch (error) {
        console.error(error);
    }

}