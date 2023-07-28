import React from "react";

const Calendar = () => {
  // Get the current date
  const currentDate = new Date();
  const currentYear = currentDate.getFullYear();
  const currentMonth = currentDate.getMonth();

  // Get the number of days in the current month
  const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

  // Generate an array of days in the current month
  const daysArray = Array.from(
    { length: daysInMonth },
    (_, index) => index + 1
  );

  return (
    <div className="calendar">
      <h2>
        {currentDate.toLocaleString("default", { month: "long" })} {currentYear}
      </h2>
      <div className="calendar-grid">
        {daysArray.map((day) => (
          <div className="day" key={day}>
            <div className="day-number">{day}</div>
            {/* Add your task list component here */}
          </div>
        ))}
      </div>
    </div>
  );
};

export default Calendar;
