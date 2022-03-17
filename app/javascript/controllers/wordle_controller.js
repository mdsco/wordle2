import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static values = { cell: String, game: Number }

  changed(event) {
    const csrfToken = document.getElementsByName("csrf-token")[0].content;

    let response = fetch('/letter_update', {
      method: 'POST',
      headers: {
        "X-CSRF-Token": csrfToken,
        'Content-Type': 'application/json;charset=utf-8'
      },
      body: JSON.stringify({ id: this.gameValue, letter: event.target.value, cell: this.cellValue })
    });

  }

}
