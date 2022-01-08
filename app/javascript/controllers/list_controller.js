import { Controller } from "stimulus";
import CableReady from "cable_ready";
// import '../external/clipboard.min'
// import { ClipboardJS } from "../external/clipboard.min.js";

let list_id = parseInt(window.location.href.split('/').pop());

export default class extends Controller {

  static values = { id: Number }

  connect() {
    this.channel = this.application.consumer.subscriptions.create(
      { channel: "ListChannel", list_id },
      {
        connect() { },

        disconnect() { },

        received(data) {
          if (data.cableReady) {
            console.log("cableRead")
            console.log(CableReady);
            console.log(data);
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
