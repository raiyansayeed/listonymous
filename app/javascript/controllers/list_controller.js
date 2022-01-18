import { Controller } from "stimulus";
import CableReady from "cable_ready";
// import '../external/clipboard.min'
// import { ClipboardJS } from "../external/clipboard.min.js";

export default class extends Controller {
  static targets = [ "message" ]
  static values = { id: Number }

  connect() {
    let list_id = parseInt(window.location.href.split('/').pop());

    this.channel = this.application.consumer.subscriptions.create(
      { channel: "ListChannel", list_id },
      {
        connect() {
              // list.update_viewers_counter();
    // perform("update_viewers_counter");

         },

        disconnect() { },

        received(data) {
          if (data.cableReady) {
            // console.log("cableRead")
            // console.log(CableReady);
            // console.log(data);
            CableReady.perform(data.operations)
          }
        },
      }
    );
  }

  copyText() {
    fetch(`/lists/${this.idValue}/create_copy_text`)
      .then(res => res.json())
      .then(data => {
        let result = JSON.stringify(data.data).replace(/["]+/g, '').replace(/(\\n)+/g, '\n');
        navigator.clipboard.writeText(data.data)
          .then(() => {
            this.messageTarget.innerHTML = "Text copied!"
            setTimeout(() => {
              this.messageTarget.innerHTML = "";
            }, 2000)
          })
          .catch(err => {
            console.log('Something went wrong', err);
          });
      })
  }

  disconnect() {
    this.channel.unsubscribe();
  }
}
