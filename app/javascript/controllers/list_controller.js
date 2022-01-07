import { Controller } from "stimulus";
import CableReady from "cable_ready";

let list_id = parseInt(window.location.href.split('/').pop());

export default class extends Controller {
  connect() {
    this.channel = this.application.consumer.subscriptions.create(
      { channel: "ListChannel", list_id },
      {
        connect() {},

        disconnect() {},

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

  disconnect() {
    this.channel.unsubscribe();
  }
}
