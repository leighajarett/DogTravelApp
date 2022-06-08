const functions = require("firebase-functions");
const vision = require('@google-cloud/vision');
const admin = require('firebase-admin');
const { getStorage } = require('firebase-admin/storage');
admin.initializeApp();

exports.getLabels = functions.https.onCall(async (data, context) => {
    // Creates a client
    const client = new vision.ImageAnnotatorClient({projectId:'leigha-bq-dev'});
    
    // Grab the deviceId
    const deviceId = data.deviceId;

    const db = admin.firestore().collection('devices').doc(deviceId).collection('images');

    // Get the images without labels from firestore
    var images = await db
      // Where there are labels
      .where("labels", "==", '')
      .get().then((querySnapshot) => {
        const tempDocs = querySnapshot.docs.map((doc) => {
          return { id: doc.id, ...doc.data() }
        })
        functions.logger.log(tempDocs)
        return tempDocs
      }).catch((error) => {
        functions.logger.log("Error getting documents: ", error);
      });
    

    const bucket = getStorage().bucket();

    // Performs label detection on the image files
    // const [result] = await client.labelDetection('/Users/leighaj/Photos for Training/IMG_0043.png');
    for (const img of images) {
      functions.logger.log('BUCKET')
      functions.logger.log(`gs://${bucket.name}/${img.storage_path}`);
      // Can't test the function with the emulator so will need to deploy
      const [result] = await client.labelDetection(`gs://${bucket.name}/${img.storage_path}`);
      functions.logger.log('RESULTS');
      functions.logger.log(result);
      const labels = result.labelAnnotations;
      functions.logger.log('LABELS');
      labels.forEach(label => functions.logger.log(label.description));
      db.doc(img.id).update({labels:labels}).then(() => {
        functions.logger.log("Document successfully written!");
      })
      .catch((error) => {
          functions.logger.error("Error writing document: ", error);
      });
    }
 });



  // Firestore
  // --> subcollection Device ID
  // --> subcollection Dog ID
  // ---> Dog Name
  // ---> Images: path, labels, geolocation, timestamp,

