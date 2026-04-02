import { useEffect, useState } from "react";
import { useLocation, useNavigate, useParams } from "react-router-dom";
import Navbar from "../Navbar";
import { Crown } from "lucide-react";
import { socket } from "../../socket";


function RankingPage({ activitySessionId, studentId, mode }) {

  const navigate = useNavigate();
  const { joinCode } = useParams();
  const [myRank, setMyRank] = useState(null);
  const savedPlayer = localStorage.getItem("student_meta");
  const playerData = savedPlayer ? JSON.parse(savedPlayer) : null;
  const [avatar, setAvatar] = useState(null);
  const [stageName, setStageName] = useState(null);
  const isTeamMode = mode === "team";
  const [teamName, setTeamName] = useState(null);
  const [teamScore, setTeamScore] = useState(null);
  const [teamRank, setTeamRank] = useState(null);
  const displayRank = isTeamMode ? teamRank : myRank;

  useEffect(() => {
    if (!studentId) return;

    socket.emit("request_my_profile", { studentId });

    const handler = (data) => {
      setStageName(data.stageName);
      setAvatar(data.avatar);
    };

    socket.on("my_profile_data", handler);

    return () => socket.off("my_profile_data", handler);
  }, [studentId]);

  /* ================= GET RANK ================= */

  useEffect(() => {

    if (!activitySessionId || !studentId) return;

    socket.emit("request_my_rank", {
      activitySessionId,
      studentId
    });

    const handler = ({ rank, teamRank, teamScore, teamName }) => {

      if (rank !== undefined) {
        setMyRank(rank);
      }

      if (teamRank !== undefined) {
        setTeamRank(teamRank);
      }

      if (teamScore !== undefined) {
        setTeamScore(teamScore);
      }

      if (teamName !== undefined) {
        setTeamName(teamName);
      }
    };

    socket.on("my_rank_update", handler);

    return () => socket.off("my_rank_update", handler);

  }, [activitySessionId, studentId]);

  /* ================= FORCE BACK TO LOBBY ================= */

  useEffect(() => {

    const handler = () => {
      console.log("teacher ended activity → back to lobby");

      localStorage.removeItem("quiz_meta");
      localStorage.removeItem("quiz_phase");
      localStorage.removeItem("quiz_q_index");

      navigate(`/class/${joinCode}/lobby`);
    };

    socket.on("force_back_to_lobby", handler);

    return () => socket.off("force_back_to_lobby", handler);

  }, [joinCode, navigate]);

  /* ================= RENDER ================= */

  if (!activitySessionId || !studentId) {
    return <div className="p-10 text-center">Ranking data missing</div>;
  }

  if (displayRank === null) {
    return <div className="p-10 text-center">Calculating rank...</div>;
  }

  return (
    <div className="w-full min-h-screen bg-slate-900 text-slate-100 flex flex-col items-center pt-[80px] pb-16">
      <Navbar />

      <h1 className="text-4xl font-bold mt-8">Ranking</h1>

      <div className="relative mt-16">

        {displayRank >= 1 && displayRank <= 5 && (
          <Crown
            className="w-16 h-16 absolute -top-10 left-1/3 -translate-x-1/2 text-amber-400 animate-bounce z-10"
          />
        )}

        <div className="relative w-[220px] h-[220px] rounded-full overflow-hidden bg-slate-800 border-4 border-slate-700 shadow-[0_0_30px_rgba(34,211,238,0.35)]">
          <img src={avatar?.bodyPath} className="absolute inset-0 w-full h-full object-contain" />
          <img src={avatar?.costumePath} className="absolute inset-0 w-full h-full object-contain" />
          <img src={avatar?.hairPath} className="absolute inset-0 w-full h-full object-contain" />
          <img src={avatar?.facePath} className="absolute inset-0 w-full h-full object-contain" />
        </div>

      </div>

      {!isTeamMode ? (
        // individual mode
        <>
          <p className="text-2xl font-bold mt-4">{stageName}</p>

          <h2 className="text-3xl font-bold mt-6 text-slate-300">
            Your Rank
          </h2>

          <div className="flex items-center gap-2 mt-1">
            <Crown className="w-6 h-6 text-amber-400" />
            <p className="text-3xl font-bold text-cyan-400">#{myRank}</p>
          </div>
        </>
      ) : (
        // team mode
        <>
          <p className="text-2xl font-bold mt-4 text-cyan-400">{teamName}</p>

          <h2 className="text-3xl font-bold mt-6 text-slate-300">
            Team Score
          </h2>

          <p className="text-3xl font-semibold text-cyan-400">{teamScore}</p>

          <h2 className="text-3xl font-bold mt-6 text-slate-300">
            Your Team Rank
          </h2>

          <div className="flex items-center gap-2 mt-1">
            <Crown className="w-6 h-6 text-amber-400" />
            <p className="text-3xl font-bold text-cyan-400">#{teamRank}</p>
          </div>
        </>
      )}
    </div>
  );
}

export default RankingPage;