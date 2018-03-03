"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const secureCompare = require("secure-compare");
const usersCol = admin
    .firestore()
    .collection('users');
function createFirUserRequest(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const data = req.body;
        // Secure key to authorize function trigger
        const key = req.query.key;
        // Exit if the keys don't match
        if (!secureCompare(key, functions.config().cron.key)) {
            console.log('The key provided in the request does not match the key set in the environment. Check that', key, 'matches the cron.key attribute in `firebase env:get`');
            res.status(403).send('Security key does not match. Make sure your "key" URL query parameter matches the ' +
                'cron.key environment variable.');
            return null;
        }
        console.log(`Creating account for ${data.email}`);
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
            const user = yield createUser(data);
            yield passUserDataToDoc(user.uid, data);
            return res
                .status(200)
                .send({ result: `Created firebase user with uid: ${user.uid} and soon there should be a firestore document populated for that user by the cloud function`, user });
        }
        catch (error) {
            console.error(error);
            return res
                .sendStatus(404)
                .send({ error: `Error creating user: ${error}` });
        }
    });
}
exports.createFirUserRequest = createFirUserRequest;
function createUser(data) {
    return __awaiter(this, void 0, void 0, function* () {
        const { email, password, first_name, last_name, mobile_no } = data;
        const firUser = yield admin
            .auth()
            .createUser({ email: email, password: password, displayName: `${last_name} ${first_name}` });
        return firUser;
    });
}
function passUserDataToDoc(userUid, data) {
    return __awaiter(this, void 0, void 0, function* () {
        const { first_name, last_name, mobile_no, address, city, postal_code, company } = data;
        try {
            const writeResult = yield usersCol
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
            });
        }
        catch (error) {
            console.error(error);
        }
    });
}
//# sourceMappingURL=createFirUserRequest.js.map