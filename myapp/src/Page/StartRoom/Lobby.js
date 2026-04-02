import React, { useEffect, useState } from "react";
import { useParams, useNavigate, useLocation } from "react-router-dom";
import { socket } from "../../socket";
import { Users } from "lucide-react";
import toast from "react-hot-toast";
import { useTeacher } from "../TeacherContext";
import QRCode from "react-qr-code";

export default function Lobby() {

  const navigate = useNavigate();
  const location = useLocation();
  const { classId, joinCode } = useParams();
  const { teacherId } = useTeacher();
  const url = window.location.origin + `/class/${joinCode}`;
  console.log(url);

  useEffect(() => {
    if (teacherId === null) return;
    if (!teacherId) {
      console.log("teacherId missing");
    }
  }, [teacherId]);

  const { playerData } = location.state || {};
  const currentUser = playerData;

  const [players, setPlayers] = useState([]);
  const [cls, setCls] = useState(null);
  const [pop, setPop] = useState(false);

  /* =========================
     SAVE PARAMS
  ========================= */

  useEffect(() => {
    if (!classId || !joinCode) return;

    localStorage.setItem("classId", classId);
    localStorage.setItem("joinCode", joinCode);
  }, [classId, joinCode]);

  /* =========================
     ROOM SOCKET LISTENERS
  ========================= */

  useEffect(() => {

    if (!joinCode) return;

    console.log("🎧 Lobby listening");

    const handleRoomPlayers = (playersInRoom) => {
      console.log("room-players", playersInRoom);
      setPlayers(playersInRoom);
    };

    const handlePlayerJoined = (newPlayer) => {
      if (!newPlayer?.studentId) return;

      setPlayers((prev) => {

        const exists = prev.some(
          (p) => String(p.studentId) === String(newPlayer.studentId)
        );

        return exists ? prev : [...prev, newPlayer];

      });
    };

    const handlePlayerUpdated = ({ studentId, stageName }) => {
      setPlayers((prev) =>
        prev.map((p) =>
          String(p.studentId) === String(studentId)
            ? { ...p, stageName }
            : p
        )
      );
    };

    socket.on("room-players", handleRoomPlayers);
    socket.on("player-joined", handlePlayerJoined);
    socket.on("player-updated", handlePlayerUpdated);

    socket.emit("join-room", {
      joinCode,
      role: "teacher",
    });

    return () => {
      socket.off("room-players", handleRoomPlayers);
      socket.off("player-joined", handlePlayerJoined);
      socket.off("player-updated", handlePlayerUpdated);
    };

  }, [joinCode]);

  /* =========================
     POP ANIMATION
  ========================= */

  useEffect(() => {

    if (players.length === 0) return;

    setPop(true);

    const t = setTimeout(() => setPop(false), 300);

    return () => clearTimeout(t);

  }, [players.length]);

  /* =========================
     CLASS DETAIL
  ========================= */

  useEffect(() => {

    if (!classId) return;

    console.log("Emitting get_class_detail for classId:", classId);

    socket.emit("get_class_detail", classId);

    const handler = (data) => {

      setCls({
        id: classId,
        name: data.Class_Name,
        section: data.Class_Section,
        subject: data.Class_Subject,
        joinCode: data.Join_Code,
      });

    };

    socket.on("class_detail_data", handler);

    return () => socket.off("class_detail_data", handler);

  }, [classId]);

  /* =========================
     ACTIVE ACTIVITY CHECK
  ========================= */

  useEffect(() => {

    if (!classId) return;

    socket.emit("get_active_activity", { classId });

  }, [classId]);

  /* =========================
     ACTIVITY STARTED
  ========================= */

  useEffect(() => {

    const handler = (payload) => {

      console.log("activity_started", payload);

      socket.emit("join_activity", {
        activitySessionId: payload.activitySessionId,
      });

      navigate(`/class/${joinCode}/lobby/quiz/${payload.activitySessionId}`, {
        state: {
          questions: payload.questions,
          totalQuestions: payload.questions.length,
          timeLimit: payload.timeLimit,
          timerType: payload.timerType,
          activitySessionId: payload.activitySessionId,
          quizId: payload.quizId,
          studentId: playerData?.studentId
        }
      });

    };

    socket.on("activity_started", handler);

    return () => socket.off("activity_started", handler);

  }, [joinCode, navigate, playerData]);

  /* =========================
     END ROOM
  ========================= */

  const endRoom = () => {

    if (!joinCode) {
      toast.error("Join code not found");
      return;
    }

    console.log("emitting end_room:", joinCode);

    socket.emit("end_room", { joinCode });

  };

  useEffect(() => {

    const handler = (res) => {

      console.log("end_room_result:", res);

      if (res.success) {

        toast.success("Room closed");
        navigate(`/classroom/${classId}`, { state: { cls } });

      } else {

        toast.error(res.message || "Failed to close the room");

      }

    };

    socket.on("end_room_result", handler);

    return () => socket.off("end_room_result", handler);

  }, [navigate, cls, classId]);

  /* =========================
     UI
  ========================= */

  return (
    <div className="flex flex-col min-h-screen bg-slate-900 text-slate-100">

      {/* TOP BAR */}
      <div className="flex justify-between items-center px-6 py-4">
        <h1 className="text-xl font-bold text-center">Lobby</h1>

        <div
          className={`flex items-center gap-2 px-4 py-2 rounded-full border font-semibold
            ${players.length >= 200
              ? "bg-rose-900/40 border-rose-500 text-rose-400"
              : "bg-slate-800 border-slate-700 text-cyan-400"
            }`}
        >
          <Users size={18} />
          <span>{players.length}/200</span>
        </div>
      </div>

      {/* MAIN */}
      <div className="flex flex-col md:flex-row gap-8 md:gap-12">

        {/* LEFT (QR) */}
        <div className="flex flex-col items-center md:items-start text-center md:text-left px-6 pt-4">

          <p className="text-slate-400 text-sm mb-2">Join Code</p>

          <div className="text-4xl font-bold tracking-widest bg-slate-800 px-4 py-2 rounded-xl text-yellow-400 mb-4">
            {joinCode}
          </div>

          <div className="bg-white p-6 rounded-2xl shadow-xl mb-4">
            <QRCode value={url} size={180} />
          </div>

          {/* <p className="text-slate-400 text-sm">
            Scan QR or enter code to join
          </p> */}

          <p className="mb-6 text-slate-400 text-sm">
            Waiting for teacher to start...
          </p>

        </div>

          {/* RIGHT (Players) */}
          <div className="flex-1 px-4 pb-32">
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-6">
              {players.map((player) => (
                <div key={player.studentId} className="flex flex-col items-center p-3 rounded-xl
                transition-transform duration-300 animate-floating hover:scale-105 bg-slate-800 border border-slate-700">
                  <div className="w-16 h-16 relative">
                    <img src={player.avatar?.bodyPath} className="absolute w-full h-full object-contain" />
                    <img src={player.avatar?.costumePath} className="absolute w-full h-full object-contain" />
                    <img src={player.avatar?.hairPath} className="absolute w-full h-full object-contain" />
                    <img src={player.avatar?.facePath} className="absolute w-full h-full object-contain" />
                  </div>

                  <span className="text-xs mt-1 truncate w-full text-center">
                    {player.stageName}
                  </span>
                </div>
              ))}
            </div>
          </div>

      </div>

      {/* BOTTOM */}
      <div className="fixed bottom-0 left-0 right-0 bg-slate-800 border-t border-slate-700 p-4 flex justify-center gap-4">

        <button
          onClick={() =>
            navigate(`/room/assign/${classId}/${joinCode}`, {
              state: {
                classId: location.state?.classId,
                joinCode: location.state?.joinCode,
              },
            })
          }
          className="px-6 py-3 rounded-lg bg-cyan-400 text-slate-900 font-semibold hover:bg-cyan-300"
        >
          Assign Activity
        </button>

        <button
          onClick={endRoom}
          className="px-6 py-3 rounded-lg bg-rose-500 text-white hover:bg-rose-400"
        >
          End Room
        </button>

      </div>
    </div>
  );
}