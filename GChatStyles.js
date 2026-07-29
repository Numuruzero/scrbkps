// Find the parent node for a space
// document.querySelector("[data-group-id='space/AAQAMxg4V1E']")
// Class name for specifically the text of the space
// yue6if
// Modify the innerText as needed
// document.querySelector("[data-group-id='space/AAQAMxg4V1E']").getElementsByClassName('yue6if')[0].innerText = 'Something Else';

const chatList = {
    "space/AAAAtIxNZnk": "OP Room",
    "space/AAQAhlU12Vc": "Logistics Room",
    "space/AAQA8I2Szc4": "Logistics Room 2"
}

const chatFinder = new MutationObserver((mutationsList, observer) => {
    for (const mutation of mutationsList) {
        if (mutation.type === 'childList') {
            for (const node of mutation.addedNodes) {
                if (node.nodeType === Node.ELEMENT_NODE) {
                    const groupId = node.getAttribute('data-group-id');
                    if (groupId) {
                        // console.log(`New chat room detected: ${groupId}`);
                        if (chatList[groupId]) {
                            const chatNameElement = node.querySelector('.yue6if');
                            chatNameElement.innerText = chatList[groupId];
                        }
                    }
                }
            }
            if (document.querySelector("[jsname='iyUusd']").style.backgroundImage == '') {
                const url = "https://drive.google.com/u/0/drive-viewer/AKGpihZiL2bGGLmUZOetvrJinYxC2-v7KIs3-IX9qMUaAAc5IkAQG1OPYjuJ4Sqyb2dK5GT3XfcWRQDhkYRn-EiKj4wVAGAmovDKNw=s1600-rw-v1?auditContext=forDisplay";
                document.querySelector("[jsname='iyUusd']").style.backgroundImage = `url(${url})`;
                document.querySelector("[jsname='iyUusd']").style.backgroundSize = 'cover';
            }
        }
    }
});

chatFinder.observe(document.body, { childList: true, subtree: true });

const newStyle = document.createElement('style');
const style1 = `.QIJiHb {
    border-radius: 17px;
    background-image: linear-gradient(-180deg, transparent -7px, rgb(239 239 239 / 84%) 7px, transparent 23px), radial-gradient(ellipse at 76% 151%, rgb(255 255 255) 0%, rgb(0 0 0 / 0%) 46%);
    background-color: #1e6d274d;
}

@keyframes glass-out {
    0% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 21%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 14%, transparent 23px);
    }
    10% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 20%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 15%, transparent 23px);
    }
    20% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 19%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 16%, transparent 23px);
    }
    30% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 18%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 17%, transparent 23px);
    }
    40% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 17%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 18%, transparent 23px);
    }
    50% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 16%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 19%, transparent 23px);
    }
    60% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 15%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 20%, transparent 23px);
    }
    70% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 14%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 21%, transparent 23px);
    }
    80% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 13%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 22%, transparent 23px);
    }
    90% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 12%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 23%, transparent 23px);
    }
    100% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 11%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 24%, transparent 23px);
    }
}

@keyframes glass-in {
    0% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 11%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 24%, transparent 23px);
    }
    10% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 12%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 23%, transparent 23px);
    }
    20% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 13%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 22%, transparent 23px);
    }
    30% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 14%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 21%, transparent 23px);
    }
    40% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 15%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 20%, transparent 23px);
    }
    50% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 16%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 19%, transparent 23px);
    }
    60% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 17%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 18%, transparent 23px);
    }
    70% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 18%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 17%, transparent 23px);
    }
    80% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 19%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 16%, transparent 23px);
    }
    90% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 20%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 15%, transparent 23px);
    }
    100% {
        background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 21%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 14%, transparent 23px);
    }
}

.jXMTWd::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* background-color: #409191; */
    /* background-image: linear-gradient(-191deg, #b1bef92e 14px, rgb(247 247 247 / 61%) 21%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 14%, transparent 23px); */
    /* background-blend-mode: color-dodge; */
    /* mix-blend-mode: color; */
    filter: blur(3px);
    animation-name: glass-in;
    animation-duration: 0.1s;
    animation-direction: forwards;
    animation-iteration-count: 1;
    animation-fill-mode: forwards;
    animation-play-state: running;
    /* transition: background 0.2s ease-in-out; */
}



.jXMTWd:hover:after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* background-color: #409191; */
    /* background-image: linear-gradient(-191deg, #002cf12e 14px, rgb(245 123 123 / 61%) 15%, transparent 23px), linear-gradient(-377deg, #b1bef945 9px, rgb(224 224 241 / 31%) 14%, transparent 23px); */
    /* background-blend-mode: color-dodge; */
    /* mix-blend-mode: color; */
    filter: blur(3px);
    animation-name: glass-out;
    animation-duration: .1s;
    animation-direction: normal;
    animation-iteration-count: 1;
    /* animation-fill-mode: reverse; */
    animation-play-state: running;
    /* transition: background 0.2s ease-in-out; */
}`
const style2 = `[data-theme=dark] {
    --message-author-background-color: #1f345b4f;
}

[data-theme=dark] .nF6pT.yqoUIf.Pxe3Yd:not(.xOWoLe) .EAOoq, [data-theme=dark] .nF6pT.yqoUIf.Pxe3Yd:not(.xOWoLe) .rogmqd
--message-author-background-color {
    background-color: #4359814f;
}

.EAOoq.LrGp7b {
    background-color: #c7404034;
    backdrop-filter: blur(2px);
    box-shadow: inset 4px 4px 4px 3px #f9eeef40, inset -4px -4px 4px 3px #00000040;
}
    
.YJxKBc .JGMh2e {
    background-color: #ffffff61;
}`;
newStyle.textContent = style2;
document.head.appendChild(newStyle);
