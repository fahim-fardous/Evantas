import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const sendNotification = functions.https.onRequest(async (req, res) => {
  if (req.method !== "POST") {
    return res.status(405).send("Method Not Allowed");
  }

  try {
    const { type, event, tokens } = req.body;

    if (!type || !event || !tokens || !Array.isArray(tokens)) {
      return res.status(400).send("Invalid request body");
    }

    let title = "";
    let message = "";

    switch (type) {
      case "event_created":
        title = "New Event Created!";
        message = `Event "${event.title}" is scheduled.`;
        break;
      case "user_joined":
        title = "Someone Joined!";
        message = `A participant joined "${event.title}".`;
        break;
      case "reminder":
        title = "Event Reminder";
        message = `Don't forget: "${event.title}" is happening soon!`;
        break;
      default:
        return res.status(400).send("Invalid notification type");
    }

    const response = await admin.messaging().sendEachForMulticast({
      tokens,
      notification: { title, body: message },
    });

    return res.status(200).send({ success: true, response });
  } catch (error) {
    console.error("Error sending notification:", error);
    return res.status(500).send("Internal Server Error");
  }
});