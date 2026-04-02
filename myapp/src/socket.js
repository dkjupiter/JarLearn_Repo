// src/socket.js
import { io } from "socket.io-client";

export const socket = io(process.env.REACT_APP_API_URL, {
  transports: ["websocket", "polling"],
  autoConnect: true,
});

// export const socket = io(process.env.REACT_APP_SERVER_URL);

