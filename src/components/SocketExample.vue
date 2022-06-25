<template>
  <div>
    <button @click="socketConnect">소켓 연결</button>
    <button @click="socketDisconnect">소켓 연결 해제</button>
    <button @click="setPub">pub 세팅</button>
    <button @click="setSub">Sub 세팅</button>
  </div>
</template>
<script>
import SockJS from "sockjs-client";
import { Client } from "@stomp/stompjs";

export default {
  setup() {
    const client = new Client({
      webSocketFactory: () => {
        return new SockJS("http://localhost:8080/ntf/Auth/connect");
      },
    });
    client.onConnect = (frame) => {
      console.log("connected", frame);
    };
    client.onDisconnect = (frame) => {
      console.log("disconnected", frame);
    };
    const socketConnect = () => {
      client.activate();
    };

    const socketDisconnect = () => {
      client.deactivate();
    };

    const setPub = () => {
      client.publish({ destination: "/ntf/Colabo/pub", body: "Hello World" });
    };
    const setSub = () => {
      client.subscribe("/ntf/Colabo/subscribe/sub", (message) => {
        console.log("sub : ", message);
      });
    };

    return { socketConnect, socketDisconnect, setPub, setSub };
  },
};
</script>
