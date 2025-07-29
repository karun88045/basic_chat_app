import consumer from "./consumer";

document.addEventListener("DOMContentLoaded", () => {
  const roomId = 1;

  const chatChannel = consumer.subscriptions.create(
    { channel: "ChatRoomChannel", room_id: roomId },
    {
      received(data) {
        console.log("Message received", data);
      },
      speak(message) {
        this.perform("speak", { message: message, room_id: roomId });
      }
    }
  );
}); 