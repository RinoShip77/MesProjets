const socket = io("http://localhost:3000");
const connectedUserContainer = document.getElementById("connectedUser");
const messageContainer = document.getElementById("message-container");
const messageForm = document.getElementById("send-container");
const messageInput = document.getElementById("message-input");
const toastLiveExample = document.getElementById("liveToast");

const name = prompt('What is your name?')
socket.emit("new-user", name);
console.log(`conected as ${name}`)

socket.on("chat-message", (data) => {
  appendMessage(`${data.name}: ${data.message}`, "sender");
});

socket.on("user-connected", (name) => {
  // setup(name, "connected");
  sendToast(`${name} is connected`);
  
});

socket.on("user-disconnected", (name) => {
  // setup(name, "disconnected");
  sendToast(`${name} is disconnected`);
});

messageForm.addEventListener("submit", (e) => {
  e.preventDefault();
  if(messageInput.value != '') {
    const message = messageInput.value;
    appendMessage(message, "reply");
    socket.emit("send-chat-message", message);
    messageInput.value = "";
  }
});

function appendMessage(message, origin) {
  let text = document.createElement("p");
  text.innerHTML = message;

  let time = document.createElement("span");
  time.classList.add("time");
  let date = new Date();
  time.innerHTML = `${date.getHours()}:${date.getMinutes()}`;

  let messageElement = document.createElement("li");
  messageElement.classList.add(origin);
  messageElement.append(text, time);

  messageContainer.appendChild(messageElement);
}

function sendToast(message) {
  const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample);
  toastBootstrap.show();
  document.getElementById('toastMessage').innerHTML = message;
}
