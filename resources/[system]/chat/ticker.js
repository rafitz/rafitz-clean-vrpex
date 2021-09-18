tickerMessages = [
    `PARA ALTERAR ENTRE OS MODOS DE CHAT, DIGITE: <span style="color: #f3486b;"> /CHAT</span>`,
];

tickerMessage = 0;
tickerDelay = 30 * 1000;

try {
    clearInterval(updateTicker);
    updateTicker = null
} catch {}

updateTicker = function() {
    var window = document.getElementsByClassName("chat-window")[0];
    var ticker = document.getElementById("ticker");

    if(ticker == null) {
        var div = document.createElement("div");
        div.setAttribute("style", "padding: 8px;background: rgba(0, 0, 0, 0.2); border-bottom: 2px solid #f3486b;");

        ticker = document.createElement("marquee");
        ticker.setAttribute("id", "ticker");
        ticker.setAttribute("dir", "left");
        ticker.innerHTML = tickerMessages[tickerMessage];

        div.prepend(ticker);
        window.prepend(div);

        setInterval(updateTicker, tickerDelay);
    } else {
        ticker.innerHTML = tickerMessages[tickerMessage]
        tickerMessage < tickerMessages.length-1 ? tickerMessage++ : tickerMessage = 0;
    }
}

updateTicker();