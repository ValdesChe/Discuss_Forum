// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

// Creating a new instance of the Socket lib
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Connect to our backend server
socket.connect()

// render all the comments for a topic
function renderComments(comments) {

    const renderedList = comments.map((comment) => {
      // console.log(comment);
      return commentTemplate(comment)
    });
    //console.log(renderedList);
    document.querySelector('.collection').innerHTML = renderedList.join(' ')
}

//
function renderComment(event) {
    const renderedComment = commentTemplate(event.comment)

    document.querySelector('.collection').innerHTML += renderedComment
}

//
function commentTemplate(comment) {
    return `
    <li class="collection-item">
       ${comment.content}
    </li>
    `;
}

const createSocket = (topicId) => {

  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => {
        //console.log("Joined successfully", resp)
        renderComments(resp.comments)
     })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on(`comments:${topicId}:new`, renderComment)

  document.querySelector('button').addEventListener('click',function () {
    const content = document.querySelector('textarea').value
    channel.push('comments:add', {content: content})
  })

}

window.createSocket = createSocket;

// Exporting the socket obj
//export default socket
