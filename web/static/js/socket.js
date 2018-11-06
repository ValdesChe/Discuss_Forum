// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

// Creating a new instance of the Socket lib
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Connect to our backend server
socket.connect()

const createSocket = (topicId) => {

  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  document.querySelector('button').addEventListener('click',function () {
    const content = document.querySelector('textarea').value
    channel.push('comments:add', {content: content})
  })

}

window.createSocket = createSocket;

// Exporting the socket obj
//export default socket
