import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import ConfirmDatePlugin from "flatpickr/dist/plugins/confirmDate/confirmDate.js";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: true,
      time_24hr: true,
      plugins: [new ConfirmDatePlugin({})],
    });
  }
}