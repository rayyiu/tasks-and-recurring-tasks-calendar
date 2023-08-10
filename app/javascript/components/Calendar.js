import React, { useState, useEffect } from "react";
import axios from "axios";

const Calendar = () => {
  const currentDate = new Date();
  const currentYear = currentDate.getFullYear();
  const currentMonth = currentDate.getMonth();

  const [month, setMonth] = useState(currentMonth);
  const [year, setYear] = useState(currentYear);
  const [tasks, setTasks] = useState([]);

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

  useEffect(() => {
    const fetchTasks = async () => {
      axios
        .post("/calendar/index", { year, month })
        .then((response) => {
          setTasks(response.data);
        })
        .catch((error) => {
          console.error("Error fetching tasks:", error);
        });
      // try {
      //   const response = await axios.get(`/calendar/${year}/${month + 1}`);
      //   console.log("Response data:", response.data);
      //   setTasks(response.data);
      // } catch (error) {
      //   console.error("Error fetching tasks", error);
      // }
    };
    fetchTasks();
  }, [year, month]);

  const daysInMonth = new Date(year, month + 1, 0).getDate();
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
      {Array.isArray(tasks) && tasks.length > 0 ? (
        <ul>
          {tasks.map((task) => (
            <li key={task.id}>{task.description}</li>
          ))}
        </ul>
      ) : (
        <p>No tasks found for this month.</p>
      )}

      {/* Display list of tasks */}
      <div className="section">
        <div className="container">
          <h2 className="title is-5">Tasks</h2>
          {tasks.length > 0 ? (
            <ul>
              {tasks.map((task) => (
                <li key={task.id}>{task.description}</li>
              ))}
            </ul>
          ) : (
            <p>No tasks found for this month.</p>
          )}
        </div>
      </div>
    </div>
  );
};

export default Calendar;
