const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const logger = require("firebase-functions/logger");

initializeApp();

exports.sendIncidentNotification = onDocumentCreated("incident_reports/{incidentId}", async (event) => {
  try {
    const incident = event.data?.data();
    if (!incident) {
      logger.warn("No incident data found");
      return;
    }

    const incidentCity = incident.location_lowercase;
    if (!incidentCity) {
      logger.warn("No location_lowercase field in incident");
      return;
    }

    const db = getFirestore();
    const usersSnapshot = await db.collection("users")
      .where("city", "==", incidentCity)
      .get();

    if (usersSnapshot.empty) {
      logger.info(`No users found in city: ${incidentCity}`);
      return;
    }

    const tokens = [];
    usersSnapshot.forEach((doc) => {
      const userData = doc.data();
      if (userData.fcmToken) {
        tokens.push(userData.fcmToken);
      }
    });

    if (tokens.length === 0) {
      logger.info(`No FCM tokens found for users in city: ${incidentCity}`);
      return;
    }

    const message = {
      notification: {
        title: "New Incident Report",
        body: `There's a new incident in your city: ${incidentCity}`,
      },
      tokens: tokens,
    };

    const response = await getMessaging().sendMulticast(message);
    logger.info(`Notifications sent: ${response.successCount} / ${tokens.length}`);

    if (response.failureCount > 0) {
      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          logger.error(`Failed to send to ${tokens[idx]}: ${resp.error}`);
        }
      });
    }
  } catch (error) {
    logger.error("Error sending incident notifications:", error);
  }
});
