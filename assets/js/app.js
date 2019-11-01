// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

function clearInput(e) {
  // this requires a user to get the event and see if target is the specific button
  // but b/c we attach events at the top level, this is an unecessary footgun
  this.firstElementChild.value = '';
}

let Hooks = {}
Hooks.clear = {
  mounted() {
    this.el.addEventListener("click", clearInput.bind(this.el));
  }
}


let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks})
liveSocket.connect()

