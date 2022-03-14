import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Connnedfkjalkjted")
  }

  changed(event) {
    console.log("Value: ", event.target.value)

    const csrfToken = document.getElementsByName("csrf-token")[0].content;

    let response = fetch('/letterupdate', {
      method: 'POST',
      headers: {
        "X-CSRF-Token": csrfToken,
        'Content-Type': 'application/json;charset=utf-8'
      },
      body: JSON.stringify({ value: event.target.value })
    });


  }

}
