let XLSX

export default async function exportClassReportExcel(report) {
  if (!report) return

  console.log("EXPORT DATA", report)

  if (!XLSX) {
    const mod = await import("xlsx-js-style")
    XLSX = mod.default
  }

  const {
    scores = [],
    quizSummary = [],
    quizAnswers = [],
    overall = {}
  } = report || {}

  const wb = XLSX.utils.book_new()

  /* ================= Students Summary ================= */

  const studentMap = {}
  const quizSet = new Set()
  const seen = new Set()
  const quizTotalMap = {}

  scores.forEach(r => {

    const cleanTitle = r.quiz_title.replace(/[:\\/?*\[\]]/g, "")
    const quizKey = `${cleanTitle}_${r.ActivitySession_ID}`

    // เก็บจำนวนข้อ
    if (!quizTotalMap[quizKey]) {
      quizTotalMap[quizKey] = r.total_question
    }
    const uniqueKey =
      `${r.Student_Number}_${r.ActivitySession_ID}`

    if (seen.has(uniqueKey)) return
    seen.add(uniqueKey)

    quizSet.add(quizKey)

    if (!studentMap[r.Student_Number]) {
      studentMap[r.Student_Number] = {
        Student_Number: r.Student_Number,
        totalCorrect: 0,
        totalQuestion: 0
      }
    }

    studentMap[r.Student_Number][quizKey] =
      `${r.correct}/${r.total_question}`

    studentMap[r.Student_Number].totalCorrect += r.correct
    studentMap[r.Student_Number].totalQuestion += r.total_question

  })

  const quizList = [...quizSet]

  const studentRows = Object.values(studentMap).map(s => {

    quizList.forEach(q => {

      if (!s[q]) {

        const totalQ = quizTotalMap[q] || 0

        s[q] = `0/${totalQ}`

        s.totalQuestion += totalQ
      }

    })

    s.Total_Score = `${s.totalCorrect}/${s.totalQuestion}`

    s.Avg_Score =
      s.totalQuestion
        ? Math.round((s.totalCorrect / s.totalQuestion) * 100)
        : null

    delete s.totalCorrect
    delete s.totalQuestion

    return s
  })

  studentRows.sort((a, b) => b.Avg_Score - a.Avg_Score)

  const sheet1 = XLSX.utils.json_to_sheet(studentRows)

  /* format Avg_Score เป็น % */

  const range1 = XLSX.utils.decode_range(sheet1["!ref"])

  for (let C = range1.s.c; C <= range1.e.c; ++C) {

    const cell =
      sheet1[XLSX.utils.encode_cell({
        r: 0,
        c: C
      })]

    if (!cell) continue

    cell.s = {
      font: { bold: true },
      fill: { fgColor: { rgb: "D9D9D9" } },
      alignment: { horizontal: "center", vertical: "center" }
    }
  }

  for (let R = 1; R <= range1.e.r; R++) {

    const cell =
      sheet1[XLSX.utils.encode_cell({
        r: R,
        c: range1.e.c
      })]

    if (cell) cell.z = '0"%"'

  }

  for (let R = 1; R <= range1.e.r; R++) {
    for (let C = 1; C <= range1.e.c; C++) {

      const cell = sheet1[XLSX.utils.encode_cell({ r: R, c: C })]

      if (cell?.v && typeof cell.v === "string" && cell.v.startsWith("0/")) {
        cell.s = {
          font: { color: { rgb: "999999" } }
        }
      }

    }
  }

  XLSX.utils.book_append_sheet(
    wb,
    sheet1,
    "Students_Summary"
  )

  /* ================= Quiz Summary ================= */

  const quizRows = quizSummary.map(q => {

    const avg = q.avg_score ?? 0

    return {
      Quiz: q.quiz_title,
      Students: q.student_count,
      Avg_Score: Math.round(avg),
      Difficulty:
        avg >= 80 ? "Easy" :
          avg >= 50 ? "Medium" : "Hard"
    }

  })

  const sheet2 = XLSX.utils.json_to_sheet(quizRows)

  /* format Avg_Score เป็น % */

  const range2 = XLSX.utils.decode_range(sheet2["!ref"])

  for (let C = range2.s.c; C <= range2.e.c; ++C) {

    const cell =
      sheet2[XLSX.utils.encode_cell({
        r: 0,
        c: C
      })]

    if (!cell) continue

    cell.s = {
      font: { bold: true },
      fill: { fgColor: { rgb: "D9D9D9" } },
      alignment: { horizontal: "center", vertical: "center" }
    }
  }

  for (let R = 1; R <= range2.e.r; R++) {

    const cell = sheet2[XLSX.utils.encode_cell({
      r: R,
      c: 2 // column Avg_Score
    })]

    if (cell) cell.z = '0"%"'

  }

  for (let R = 1; R <= range2.e.r; R++) {

    const diffCell = sheet2[XLSX.utils.encode_cell({
      r: R,
      c: 3 // Difficulty column
    })]

    if (!diffCell || !diffCell.v) continue

    let color = "FFFFFF"

    if (diffCell.v === "Easy") {
      color = "C6EFCE" // เขียว
    }
    else if (diffCell.v === "Medium") {
      color = "FFF2CC" // เหลือง
    }
    else if (diffCell.v === "Hard") {
      color = "FFC7CE" // แดง
    }

    diffCell.s = {
      fill: { fgColor: { rgb: color } },
      alignment: { horizontal: "center" }
    }

  }

  XLSX.utils.book_append_sheet(
    wb,
    sheet2,
    "Quiz_Summary"
  )

  /* ================= Quiz Question Analysis ================= */

  const quizMap = {}

  quizAnswers.forEach(r => {

    const cleanTitle = r.quiz_title.replace(/[:\\/?*\[\]]/g, "")
    const quizKey = `${cleanTitle} (#${r.ActivitySession_ID})`

    if (!quizMap[quizKey])
      quizMap[quizKey] = []

    quizMap[quizKey].push(r)

  })

  Object.entries(quizMap).forEach(([quizKey, sessionData], i) => {

    const rows = buildAnswerSheet(
      sessionData,
      report.studentAnswers
    )

    const sheet = XLSX.utils.json_to_sheet(rows)

    styleAnswerSheet(sheet)

    XLSX.utils.book_append_sheet(
      wb,
      sheet,
      safeSheetName(quizKey, i)
    )

  })

  /* ================= Overall ================= */

  const overallRows = [

    { Metric: "Total Students", Value: overall.total_student ?? 0 },

    { Metric: "Total Quiz", Value: overall.total_quiz ?? 0 },

    { Metric: "Average Accuracy", Value: overall.avg_accuracy ?? 0 },

    { Metric: "Average Time", Value: overall.avg_time ?? 0 }

  ]

  const sheetLast = XLSX.utils.json_to_sheet(overallRows)
  const range3 = XLSX.utils.decode_range(sheetLast["!ref"])

  for (let R = 1; R <= range3.e.r; R++) {

    const cell =
      sheetLast[XLSX.utils.encode_cell({
        r: R,
        c: 1
      })]

    if (R === 3 && cell) cell.z = '0"%"'

  }

  XLSX.utils.book_append_sheet(
    wb,
    sheetLast,
    "Overall"
  )

  XLSX.writeFile(wb, "Class_report.xlsx")
}

/* ================= Question Analysis Builder ================= */
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

      note = "Ordering - Correct Rate"

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

/* ================= Style ================= */
function styleAnswerSheet(sheet) {

  const range = XLSX.utils.decode_range(sheet["!ref"]);
  const merges = []

  let startRow = 1
  let currentQuestion = null

  /* ================= HEADER ================= */

  for (let C = range.s.c; C <= range.e.c; ++C) {

    const cell = sheet[XLSX.utils.encode_cell({ r: 0, c: C })]

    if (!cell) continue

    cell.s = {
      font: { bold: true },
      fill: { fgColor: { rgb: "D9D9D9" } },
      alignment: { horizontal: "center" }
    }
  }

  /* ================= BODY ================= */

  for (let R = 1; R <= range.e.r; ++R) {

    const qCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 0 })]

    const correctCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 3 })]

    const percentCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 5 })]

    const noteCell =
      sheet[XLSX.utils.encode_cell({ r: R, c: 6 })]

    const note = noteCell?.v || ""

    /* ================= QUESTION MERGE ================= */

    if (qCell && qCell.v !== undefined) {

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

    /* ================= CORRECT ================= */

    if (correctCell && correctCell.v !== undefined) {

      correctCell.s = {
        fill: {
          fgColor: {
            rgb: correctCell.v === "True"
              ? "C6EFCE"
              : "FFC7CE"
          }
        },
        alignment: { horizontal: "center" }
      }
    }

    /* ================= PERCENT (สำคัญสุด) ================= */

    if (percentCell && percentCell.v !== undefined) {

      let fillColor = "C6EFCE" // default = green

      // ORDERING
      if (note.includes("Ordering")) {
        fillColor = "BDD7EE"
      }

      // MISCONCEPTION (override ทุกอย่าง)
      if (
        correctCell?.v === "False" &&
        percentCell.v >= 30
      ) {
        fillColor = "F8CBAD"
      }

      percentCell.s = {
        fill: { fgColor: { rgb: fillColor } }
      }

      percentCell.z = '0"%"'
    }

  }

  /* ================= FINAL MERGE ================= */

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
    { wch: 20 },
    { wch: 12 },
    { wch: 8 },
    { wch: 15 },
    { wch: 10 },
    { wch: 25 }
  ]
}

function safeSheetName(name, index) {

  const clean = name
    .replace(/[:\\\/\?\*\[\]]/g, "")

  const prefix = `Quiz${index + 1}-`

  return (prefix + clean).substring(0, 31)

}