import consumer from "./consumer"

window.initConversationChannel = function(conversationId) {
  const channel = consumer.subscriptions.create(
    { channel: "ConversationChannel", conversation_id: conversationId },

    {
      received(data) {
        if (data.type === "message") {
          const messages = document.getElementById("messages")
          const p = document.createElement("div")
          p.id = `message-${data.id}`
          p.className = "text-end mb-2"
          p.innerHTML = `
            <div class="bg-success text-white d-inline-block rounded-3 px-3 py-2">
              <strong>You:</strong> ${data.content}
              <div class="text-end small mt-1">
                ${data.timestamp} ✅
              </div>
            </div>
          `
          messages.appendChild(p)

          // ✅ Auto-scroll to bottom when new message is added
          messages.scrollTop = messages.scrollHeight
        }
      },


      speak(message) {
        this.perform("speak", { message: message })
      },

      markAsRead(ids) {
        this.perform("mark_as_read", { message_ids: ids })
      }
    }
  )

  // Read detector
  const unreadIds = Array.from(document.querySelectorAll(".message.unread")).map(el => el.dataset.id)
  if (unreadIds.length > 0) {
    channel.markAsRead(unreadIds)
    unreadIds.forEach(id => {
      const el = document.querySelector(`[data-id='${id}']`)
      if (el) el.classList.remove("unread")
    })
  }

  document.getElementById("send-button").addEventListener("click", () => {
    const input = document.getElementById("message-input")
    const message = input.value.trim()
    if (message.length > 0) {
      channel.speak(message)
      input.value = ""
    }
  })
}
