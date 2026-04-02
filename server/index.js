require("dotenv").config();
const express = require("express");
const app = express();

const http = require("http");
const { Server } = require("socket.io");
const cors = require("cors");
const path = require("path");
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use("/uploads", express.static("uploads"));

const uploadQuestionImage = require("./middlewares/uploadQuestionImage");

app.post(
  "/upload-question-image",
  uploadQuestionImage.single("image"),
  (req, res) => {
    res.json({ url: req.file.path });
  }
);

// app.get("/", (req, res) => {
//   res.send("Teacher server is running");
// });

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});
const rooms = {};

app.use("/avatars", require("./routes/avatars"));

// connection มีที่เดียว
io.on("connection", (socket) => {
  console.log("User connected", socket.id);

  require("dotenv").config();
  
  // เรียก join module
  require("./routes/join")(io, socket, rooms);
  // เรียก auth module
  require("./routes/auth")(socket);
  // เรียก class module
  require("./routes/classes")(io, socket, rooms);
  // เรียก quiz module
  require("./routes/quizzes")(socket);
  // เรียก activityPlan
  require("./routes/activityPlan")(socket);
  // เรียก assign activity module
  require("./routes/assign_activity")(io, socket);

  // quiz realtime
  require("./routes/quizAnswer")(io, socket);
  // require("./routes/quizScoring")(io, socket);
  require("./routes/quizFinal")(io, socket);
  require("./routes/quizAnalysis")(socket);

  require("./routes/quizReport")(socket);

  require("./routes/activity_poll")(io, socket);
  require("./routes/activity_interactive_board")(io, socket);
});

app.use(express.static(path.join(__dirname, "../myapp/build")));

app.use((req, res) => {
  res.sendFile(path.join(__dirname, "../myapp/build/index.html"));
});

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});