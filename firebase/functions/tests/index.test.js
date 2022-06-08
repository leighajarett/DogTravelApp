const test = require("firebase-functions-test")();
adminInitStub = sinon.stub(admin, "initializeApp");
myFunctions = require("../index.js");

// Wrap function
const wrapped = test.wrap(myFunctions.getLabels);

// Make snapshot
wrapped({"deviceId":"2EC57C8F-546B-41F0-B51B-D8191E9472CE"});