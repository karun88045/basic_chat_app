import consumer from "./consumer"

consumer.subscriptions.create("PresenceChannel", {
  received(data) {
    const list = document.getElementById("online-users")
    const id = `user-${data.user.replace(/[@.]/g, '-')}`

    if (data.type === "join") {
      if (!document.getElementById(id)) {
        const li = document.createElement("li")
        li.id = id
        li.className = "list-group-item"
        li.innerHTML = `🟢 ${data.user}`
        list.appendChild(li)
      }
    } else if (data.type === "leave") {
      const el = document.getElementById(id)
      if (el) el.remove()
    }
  }
})
