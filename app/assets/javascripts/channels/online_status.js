var notifyStatus, userSelf;

App.online_status = App.cable.subscriptions.create("OnlineStatusChannel", {
  connected: function(data) {
    this.perform("online");
    if (Notification.permission !== 'granted') {
      return Notification.requestPermission();
    }
  },
  disconnected: function(data) {
    return this.perform("offline");
  },
  received: function(data) {
    return this.update_status(data);
  },
  update_status: function(data) {
    if (($("[data-user-id='" + data.user + "']").length)) {
      return this.toggleStatus(data);
    }
  },
  toggleStatus: function(data) {
    var list_class, user_id;
    list_class = "class='list__user";
    user_id = "[data-user-id='" + data.user + "']";
    if (data.status === "online") {
      $(user_id).replaceWith("<li " + list_class + (" list__user-online' data-user-id='"
       + data.user + "'>*" + data.user + "</li>"));
      if (!userSelf(data)) {
        return notifyStatus("online", data);
      }
    } else {
      $(user_id).replaceWith("<li " + list_class + (" list__user-offline' data-user-id='"
       + data.user + "'>" + data.user + "</li>"));
      if (!userSelf(data)) {
        return notifyStatus("offline", data);
      }
    }
  }
}, userSelf = function(data) {
  return Cookies.get('username') === data.user;
}, notifyStatus = function(status, data) {
  var notification;
  if (Notification.permission === 'granted') {
    return notification = new Notification("Chatrooms", {
      icon: window.location.origin + "/images/message.png",
      body: data.user + " is " + status
    });
  }
});
