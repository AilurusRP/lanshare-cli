console.log("Hello Panda Filehelper");

function startSSEClient() {
    const msgList = document.querySelector("div.msg-list-box-inner");

    const eventSource = new EventSource("/events");
    eventSource.onmessage = msgEvent => {
        console.log(msgEvent);
        const msgData = msgEvent.data;
        console.log(msgData.split(""));
        addLeftMsg(msgList, msgData);
    };
    eventSource.onerror = err => console.log(err);
}

function addLeftMsg(msgList, msgData) {
    const newMsg = document.createElement("div");
    newMsg.classList.add("msg-list-elem-left");
    newMsg.innerText = msgData;
    msgList.appendChild(newMsg);
}

function addRightMsg(msgData) {
    const msgList = document.querySelector("div.msg-list-box-inner");

    const newMsgOutter = document.createElement("div");
    newMsgOutter.classList.add("msg-list-elem-right-outter");

    const newMsg = document.createElement("div");
    newMsg.classList.add("msg-list-elem-right");

    newMsg.innerText = msgData;

    newMsgOutter.appendChild(newMsg);
    msgList.appendChild(newMsgOutter);
}

function setButtonState(msgEditor) {
    const sendButton = document.querySelector("div.msg-editor-send-button");

    if (msgEditor.value !== "") {
        sendButton.classList.add("msg-editor-send-button-enabled");
    } else {
        sendButton.classList.remove("msg-editor-send-button-enabled");
    }
}

function keyShortcutHandler(event) {
    if (event.key === "Enter" && event.ctrlKey === true) sendMsg();
}

function handleKeyShortcut(handle) {
    if (handle === true) {
        document.addEventListener("keyup", keyShortcutHandler);
    } else if (handle === false) {
        document.removeEventListener("keyup", keyShortcutHandler);
    } else {
        throw Error("Param handle must be a boolean!");
    }
}

async function sendMsg() {
    const msgEditor = document.querySelector("textarea.msg-editor-text-area");
    const response = await fetch("/web-msg", {
        method: "POST",
        body: JSON.stringify({
            msg: msgEditor.value,
        }),
    });
    const responseData = await response.json();
    if (responseData?.code === 200) {
        addRightMsg(msgEditor.value);
        msgEditor.value = "";
        setButtonState(msgEditor);
    }
}
