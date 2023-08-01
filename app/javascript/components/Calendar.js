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
    <div className="section">
      <div className="container">
        <h2 className="title is-4">
          {new Date(year, month).toLocaleString("default", { month: "long" })}{" "}
          {year}
        </h2>
        <div className="columns is-multiline">
          {daysArray.map((day) => (
            <div className="column is-one-fifth" key={day}>
              <div className="box">
                <div className="has-text-centered">{day}</div>
                {/* Add your task list component here */}
              </div>
            </div>
          ))}
        </div>
        <div className="buttons">
          <button className="button" onClick={goToPreviousMonth}>
            Previous Month
          </button>
          <button className="button" onClick={goToNextMonth}>
            Next Month
          </button>
        </div>
      </div>
    </div>
  );
};

export default Calendar;
