let XLSX;

export default async function exportQuizReportExcel(report) {

  if (!report) return;

  if (!XLSX) {
    const mod = await import("xlsx-js-style");
    XLSX = mod.default;
  }

  const wb = XLSX.utils.book_new();

  /* ================= Scores ================= */

  const scores = buildScoreSheet(report.students);
  const scoreSheet = XLSX.utils.json_to_sheet(scores);

  styleScoreSheet(scoreSheet);

  XLSX.utils.book_append_sheet(wb, scoreSheet, "Student_scores");


  /* ================= Answers ================= */

  const answers = buildAnswerSheet(
    report.answerAnalytics,
    report.students
  );
  const answerSheet = XLSX.utils.json_to_sheet(answers);

  styleAnswerSheet(answerSheet);

  XLSX.utils.book_append_sheet(wb, answerSheet, "Quiz_answers");


  /* ================= Overall ================= */

  const overall = buildOverallSheet(report);
  const overallSheet = XLSX.utils.json_to_sheet(overall);

  XLSX.utils.book_append_sheet(wb, overallSheet, "Overall");


  XLSX.writeFile(wb, "Quiz_report.xlsx");

}


/* =================================
   Scores Sheet
================================= */
function buildScoreSheet(raw = []) {

  const map = {};
  const qMap = {};
  let qIndex = 1;

  // วมคำตอบต่อ (student + question)
  const studentQuestionMap = {};

  raw.forEach(r => {

    const key = `${r.Student_ID}_${r.Question_ID}`;

    if (!studentQuestionMap[key]) {
      studentQuestionMap[key] = {
        Student_ID: r.Student_ID,
        Student_Number: r.Student_Number,
        Question_ID: r.Question_ID,
        answers: [],
        hasWrong: false
      };
    }

    studentQuestionMap[key].answers.push({
      text: r.Option_Text,
      isCorrect: r.is_correct
    });

    if (!r.is_correct) {
      studentQuestionMap[key].hasWrong = true;
    }

  });

  // เอามาคิดคะแนน "ต่อข้อ"
  Object.values(studentQuestionMap).forEach(q => {

    if (!qMap[q.Question_ID]) {
      qMap[q.Question_ID] = `Q${qIndex++}`;
    }

    if (!map[q.Student_ID]) {
      map[q.Student_ID] = {
        Student_Number: q.Student_Number,
        Correct: 0,
        Wrong: 0
      };
    }

    const key = qMap[q.Question_ID];

    // แสดงคำตอบ
    map[q.Student_ID][key] =
      q.answers
        .map(a => `${a.text} (${a.isCorrect ? "✔" : "✘"})`)
        .join(", ");

    if (q.answers[0]?.isCorrect) {
      map[q.Student_ID].Correct++;
    } else {
      map[q.Student_ID].Wrong++;
    }

  });

  // convert to array
  const rows = Object.values(map).map(s => ({
    ...s,
    Total: s.Correct
  }));

  // sort
  rows.sort((a, b) => b.Total - a.Total);

  // rank
  rows.forEach((r, i) => {
    r.Rank = i + 1;
  });

  return rows;
}


/* =================================
   Answers Sheet
================================= */
function buildAnswerSheet(data = [], students = []) {

  const qMap = {}
  let qIndex = 1

  const rows = []
  let currentQ = null

  // รวมจำนวนคนต่อข้อ
  const questionTotals = {}

  data.forEach(r => {
    if (!questionTotals[r.Question_ID])
      questionTotals[r.Question_ID] = 0

    questionTotals[r.Question_ID] += Number(r.selected_count)
  })

  // คำนวณ correct rate สำหรับ ordering
  const orderingStats = {};

  // group ก่อน (student + question)
  const seen = {};

  students.forEach(s => {

    const key = `${s.Student_ID}_${s.Question_ID}`;

    if (!seen[key]) {
      seen[key] = {
        Question_ID: s.Question_ID,
        is_correct: s.is_correct
      };
    }

  });

  Object.values(seen).forEach(s => {

    const qid = s.Question_ID;

    if (!orderingStats[qid]) {
      orderingStats[qid] = { total: 0, correct: 0 };
    }

    orderingStats[qid].total++;

    if (s.is_correct) {
      orderingStats[qid].correct++;
    }

  });

  const studentCountPerQuestion = {};

  students.forEach(s => {

    const key = `${s.Student_ID}_${s.Question_ID}`;

    if (!studentCountPerQuestion[s.Question_ID]) {
      studentCountPerQuestion[s.Question_ID] = new Set();
    }

    studentCountPerQuestion[s.Question_ID].add(s.Student_ID);

  });

  let note = "";

  let percent = 0;

  // loop หลัก
  data.forEach(r => {

    if (!qMap[r.Question_ID])
      qMap[r.Question_ID] = `Q${qIndex++}`

    const q = qMap[r.Question_ID]

    if (currentQ && currentQ !== q)
      rows.push({})

    const total = questionTotals[r.Question_ID] || 1

    /* ================= ORDERING ================= */

    if (r.Question_Type === "ordering") {

      const stat = orderingStats[r.Question_ID] || { total: 1, correct: 0 }

      percent = Math.round((stat.correct / stat.total) * 100)
      
      note ="Ordering - Correct Rate"

      if (!r.is_correct && percent >= 30) {
        note = "Misconception"
      }

      rows.push({
        Question: q,
        Question_Text: r.Question_Text,
        Option_Text: r.Option_Text,
        Correct: r.is_correct ? "True" : "False",
        Selected_Count: r.selected_count,
        Percent: percent,
        Note: note
      })

    }

    /* ================= MULTIPLE ================= */

    else if (r.Question_Type === "multiple") {

      const studentTotal =
        studentCountPerQuestion[r.Question_ID]?.size || 1;

      percent = Math.round((Number(r.selected_count) / studentTotal) * 100);

      note = "Multiple - Selection rate"

      if (!r.is_correct && percent >= 30) {
        note = "Misconception"
      }

      rows.push({
        Question: q,
        Question_Text: r.Question_Text,
        Option_Text: r.Option_Text,
        Correct: r.is_correct ? "True" : "False",
        Selected_Count: r.selected_count,
        Percent: percent,
        Note: note
      })

    }

    /* ================= SINGLE ================= */

    else {
      note = "Single - Correct distribution"

      percent = Math.round((Number(r.selected_count) / total) * 100)

      if (!r.is_correct && percent >= 30) {
        note = "Misconception"
      }

      rows.push({
        Question: q,
        Question_Text: r.Question_Text,
        Option_Text: r.Option_Text,
        Correct: r.is_correct ? "True" : "False",
        Selected_Count: r.selected_count,
        Percent: percent,
        Note: note
      })

    }

    currentQ = q

  })

  return rows
}

/* =================================
   Overall Sheet
================================= */
function buildOverallSheet(report) {

  const students = report.students || []
  const totalQuestions = report.eachQuestion?.length || 0

  const scoreMap = {}

  students.forEach(s => {

    if (!scoreMap[s.Student_ID])
      scoreMap[s.Student_ID] = 0

    if (s.is_correct)
      scoreMap[s.Student_ID]++

  })

  const scores = Object.values(scoreMap)

  const avg = scores.length
    ? (scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(2)
    : 0

  const max = scores.length ? Math.max(...scores) : 0
  const min = scores.length ? Math.min(...scores) : 0

  return [

    { Metric: "Total Questions", Value: totalQuestions },
    { Metric: "Total Students", Value: scores.length },
    { Metric: "Average Score", Value: avg },
    { Metric: "Average Time (seconds)", Value: report.overall?.avgTime ?? 0 },
    { Metric: "Max Score", Value: max },
    { Metric: "Min Score", Value: min }

  ]

}

/* =================================
   Styles
================================= */
function styleScoreSheet(sheet) {

  const range = XLSX.utils.decode_range(sheet["!ref"]);

  for (let R = range.s.r; R <= range.e.r; ++R) {

    for (let C = range.s.c; C <= range.e.c; ++C) {

      const cell = sheet[XLSX.utils.encode_cell({ r: R, c: C })];
      if (!cell || !cell.v) continue;

      // header
      if (R === 0) {
        cell.s = {
          font: { bold: true },
          fill: { fgColor: { rgb: "D9D9D9" } },
          alignment: { horizontal: "center" }
        };
        continue;
      }

      // เริ่มที่คอลัมน์ Q1 (C >= 3)
      if (C >= 3) {

        const value = String(cell.v);

        const hasCorrect = value.includes("✔");
        const hasWrong = value.includes("✘");

        if (hasCorrect || hasWrong) {

          // ผิด
          if (hasWrong && !hasCorrect) {
            cell.s = {
              fill: { fgColor: { rgb: "FFC7CE" } }
            };
          }

          // ถูก
          else if (hasCorrect && !hasWrong) {
            cell.s = {
              fill: { fgColor: { rgb: "C6EFCE" } }
            };
          }

          // partial
          else {
            cell.s = {
              fill: { fgColor: { rgb: "FFEB9C" } }
            };
          }

        }

      }

    }

  }

}

function styleAnswerSheet(sheet) {

  const range = XLSX.utils.decode_range(sheet["!ref"]);
  const merges = []

  let startRow = 1
  let currentQuestion = null

  // header 
  for (let C = range.s.c; C <= range.e.c; ++C) {
    sheet[XLSX.utils.encode_cell({ r: 0, c: C })].s = {
      font: { bold: true },
      fill: { fgColor: { rgb: "D9D9D9" } },
      alignment: { horizontal: "center" }
    };
  }


  for (let R = 1; R <= range.e.r; ++R) {

    const qCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 0 })]

    const correctCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 3 })]

    const percentCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 5 })]

    if (qCell) {

      if (currentQuestion === null)
        currentQuestion = qCell.v

      if (qCell.v !== currentQuestion) {

        merges.push({
          s: { r: startRow, c: 0 },
          e: { r: R - 2, c: 0 }
        })

        merges.push({
          s: { r: startRow, c: 1 },
          e: { r: R - 2, c: 1 }
        })

        startRow = R
        currentQuestion = qCell.v

      }

      qCell.s = {
        font: { bold: true },
        fill: { fgColor: { rgb: "BDD7EE" } },
        alignment: { vertical: "center", horizontal: "center" }
      }

    }

    if (correctCell) {

      if (correctCell.v === "True") {

        correctCell.s = {
          fill: { fgColor: { rgb: "C6EFCE" } },
          alignment: { horizontal: "center" }
        }

      } else {

        correctCell.s = {
          fill: { fgColor: { rgb: "FFC7CE" } },
          alignment: { horizontal: "center" }
        }

      }

    }

    // Highlight distractor
    if (percentCell) {

      const noteCell =
        sheet[XLSX.utils.encode_cell({ r: R, c: 6 })]

      const note = noteCell?.v || ""

      // ORDERING
      if (note.includes("Ordering")) {
        percentCell.s = {
          fill: { fgColor: { rgb: "BDD7EE" } }
        }
      }

      // NORMAL
      else {
        percentCell.s = {
          fill: { fgColor: { rgb: "C6EFCE" } }
        }
      }

      
      // MISCONCEPTION
      if (percentCell && percentCell.v >= 30 && correctCell?.v === "False") {

      percentCell.s = {
        fill: { fgColor: { rgb: "F8CBAD" } }
      }

    }

      percentCell.z = '0"%"'
    }

  }

  merges.push({
    s: { r: startRow, c: 0 },
    e: { r: range.e.r, c: 0 }
  })

  merges.push({
    s: { r: startRow, c: 1 },
    e: { r: range.e.r, c: 1 }
  })

  sheet["!merges"] = merges

  sheet["!cols"] = [
    { wch: 8 },
    { wch: 15 },
    { wch: 12 },
    { wch: 8 },
    { wch: 15 },
    { wch: 10 }
  ]

}