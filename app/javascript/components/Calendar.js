import React, { useState } from "react";

const Calendar = () => {
  // Get the current date
  const currentDate = new Date();
  const currentYear = currentDate.getFullYear();
  const currentMonth = currentDate.getMonth();

  // State to track the current month and year
  const [month, setMonth] = useState(currentMonth);
  const [year, setYear] = useState(currentYear);

  const goToPreviousMonth = () => {
    if (month === 0) {
      setMonth(11);
      setYear(year - 1);
    } else {
      setMonth(month - 1);
    }
  };

  const goToNextMonth = () => {
    if (month === 11) {
      setMonth(0);
      setYear(year + 1);
    } else {
      setMonth(month + 1);
    }
  };

  // Get the number of days in the current month
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  // Generate an array of days in the current month
  const daysArray = Array.from(
    { length: daysInMonth },
    (_, index) => index + 1
  );

  return (
    <div className="calendar">
      <h2>
        {new Date(year, month).toLocaleString("default", { month: "long" })}{" "}
        {year}
      </h2>
      <div className="calendar-grid">
        {daysArray.map((day) => (
          <div className="day" key={day}>
            <div className="day-number">{day}</div>
            {/* Add your task list component here */}
          </div>
        ))}
      </div>
      <div className="calendar-navigation">
        <button onClick={goToPreviousMonth}>Previous Month</button>
        <button onClick={goToNextMonth}>Next Month</button>
      </div>
    </div>
  );
};

export default Calendar;
