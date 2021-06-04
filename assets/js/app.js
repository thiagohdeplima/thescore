// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import 'bootstrap';


import {Socket} from "phoenix"
import topbar from "topbar"
import {LiveSocket} from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

function prepareCsvFromPlayersTable() {
  const rows = document.getElementById("players");
  const columns = document.getElementById("table-columns");

  var csvHeaders = [];
  var csvRows = "";
  var csvContent;

  for(var i = 0; i < columns.childElementCount; i++) {
    if(columns.children[i].outerText === "") {
      csvHeaders.push("Name")
    }
    else {
      csvHeaders.push(columns.children[i].outerText.replace(" ⧫", ""));
    }
  };

  for(var i = 0; i < rows.childElementCount; i++) {
    csvRows += rows.children[i].outerText.split("\t").join(",") + "\n";
  }

  csvContent = csvHeaders.join(",") + "\n" + csvRows

  return csvContent;
}

function savePreparedCSV(preparedCsv) {
  const downloadCSVLink = document.createElement("a");
  const downloadableCSV = new Blob([preparedCsv], {type: "text/csv"});

  downloadCSVLink.style.display = "none";

  document.body.appendChild(downloadCSVLink);

  downloadCSVLink.download = 'nft-expor.csv';
  downloadCSVLink.href = window.URL.createObjectURL(downloadableCSV);

  downloadCSVLink.click();
}

function exportToCsv() {
  let csvContent = prepareCsvFromPlayersTable();

  savePreparedCSV(csvContent);
};

const btnDownload = document.getElementById("btnDownload");

btnDownload.addEventListener('click', exportToCsv, false);
