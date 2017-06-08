var appendMember, appendPost, checkForNewPost, checkForUserTyping;
var clearTyping, createPost, getChatroom, getUser;
var notifyMessage, post, userSelf, userTyping, usersList;

App.chatroom = App.cable.subscriptions.create({
  channel: 'ChatroomChannel'
  }, {
    received: function(data) {
      checkForUserTyping(data);
      return checkForNewPost(data);
    }
  }, checkForUserTyping = function(data) {
    if (data.user_typing !== "default") {
      return userTyping(data);
    }
  }, checkForNewPost = function(data) {
    if (data.chatroom !== "default" && data.post !== "default") {
      appendPost(data);
      clearTyping();
      if (!userSelf(data)) {
        notifyMessage(data);
      }
      if (data.member) {
        return appendMember(data);
      }
    }
  }, appendPost = function(data) {
    var height;
    $("" + (createPost(data))).appendTo($("ul[data-chatroom-id='"
      + data.chatroom + "']"));
    height = $("ul[data-chatroom-id]").prop('scrollHeight');
    $("ul[data-chatroom-id]").scrollTop(height);
    if (userSelf(data)) {
      return $('[data-user-typing]').val('');
    }
  }, appendMember = function(data) {
    var classes, listFormat;
    classes = function() {
      return "list__user list__user-online";
    };
    listFormat = function(data) {
      return "<li data-user-id='" + data.user + "'> *" + data.user + " </li>";
    };
    if (!((usersList(data)).has($("[data-user-id='" + data.user + "']")).length)) {
      return $("" + (listFormat(data))).appendTo(usersList(data)).addClass(classes);
    }
  }, userSelf = function(data) {
    return getUser() === data.user;
  }, getUser = function() {
    return Cookies.get('username');
  }, createPost = function(data) {
    var person;
    person = userSelf(data) ? 'myself' : 'other';
    return post(data, person);
  }, usersList = function(data) {
    return $("[data-users-online='" + data.chatroom + "']");
  }, post = function(data, person) {
    var postAuthor, postContent, postString;
    postContent = "<div class='list__post list__post-" + person + "'> "
     + (emojione.shortnameToUnicode(markdown.toHTML(data.post))) + " </div>";
    postAuthor = "<div> <i class='fa fa-user-circle " + person +
     "'></i> <span> - " + data.user + ", just now </span> </div>";
    return postString = "<li>" + ("" + postContent) + ("" + postAuthor) + "</li>";
  }, notifyMessage = function(data) {
    var notification;
    if (Notification.permission === 'granted') {
      return notification = new Notification(data.user
        + " posted in " + data.chatroom, {
        icon: window.location.origin + "/images/message.png",
        body: "" + (emojione.shortnameToUnicode(data.post))
      });
    }
  }, userTyping = function(data) {
    var chatroom, url, user;
    chatroom = data.chatroom;
    user = data.user_typing;
    url = window.location.origin + '/images/gifs/fluid_dots.gif';
    if (user !== getUser()) {
      $("span[data-typing-id='" + chatroom + "']").replaceWith(
        $("<span class='menu__chatroom-typing' data-typing-id='"
         + chatroom + "'>" + user +
         " is typing <img class='menu__typing-image' src='"
         + url + "'></span>"));
      return setTimeout(clearTyping, 5000);
    }
  }, getChatroom = function() {
    return $("h2[data-chatroom-id]").data("chatroom-id");
  }, clearTyping = function() {
    return $("span[data-typing-id]").replaceWith(
      "<span class='menu__chatroom-typing' data-typing-id='"
       + (getChatroom()) + "'></span>");
});

$(document).on("keydown", "[data-user-typing=" + (getUser()) + "]",
 function(event) {
  return App.chatroom.perform("user_typing", {
    user: getUser(),
    chatroom: getChatroom()
  });
});
