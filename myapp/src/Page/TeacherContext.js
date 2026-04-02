import { createContext, useContext, useState, useEffect } from "react";
import { socket } from "../socket";

const TeacherContext = createContext();

export const useTeacher = () => useContext(TeacherContext);

export const TeacherProvider = ({ children }) => {
  const [teacherId, setTeacherId] = useState(() => {
    return localStorage.getItem("teacherId") || "";
  });

  useEffect(() => {
    socket.on("connect", () => {
      const id = localStorage.getItem("teacherId");
      if (id) {
        socket.emit("reconnect_teacher", { teacherId: id });
      }
    });

    return () => socket.off("connect");
  }, []);

  useEffect(() => {
    const savedId = localStorage.getItem("teacherId");
    if (savedId) {
      setTeacherId(savedId);
    }
  }, []);

  useEffect(() => {
    console.log("teacherId changed:", teacherId);

    if (teacherId) {
      localStorage.setItem("teacherId", teacherId);
    }

  }, [teacherId]);

  return (
    <TeacherContext.Provider value={{ teacherId, setTeacherId }}>
      {children}
    </TeacherContext.Provider>
  );
};