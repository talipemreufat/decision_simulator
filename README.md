# Decision Simulator

A Flutter-based decision support application designed to evaluate user-defined scenarios using
weighted analytical criteria.  
Instead of tracking tasks or expenses, the app focuses on **decision-making logic**, helping users
compare alternatives based on cost, risk, and time considerations.

---

## 🚀 Features

- Create decisions by comparing two alternatives
- Define decision criteria:
  - Cost
  - Risk
  - Time
- Weighted scoring system for objective evaluation
- Transparent recommendation with explanation ("Why this result?")
- Decision history tracking
- Local data persistence using SharedPreferences
- Clean and extensible Flutter architecture

---
## 📊 Key Capabilities

### 🔹 Decision Criteria
Users assign numerical values (0–10) to cost, risk, and time for each option.

### 🔹 Weighted Scoring
Scores are calculated using predefined weights to simulate rational trade-offs between criteria.

### 🔹 Decision History
All decisions are stored locally and can be reviewed later, including:
- Options compared
- Final scores
- Recommendation result

### 🔹 Explanation Engine
Each recommendation includes a short textual explanation describing the reasoning behind the result.

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **SharedPreferences** (local persistence)
- Material 3 UI

