import React, { useState, createContext, useContext, useEffect } from "react";

const RECURRENCE_RATES = [
  { label: "Daily", value: "daily" },
  { label: "Every weekday (Mon to Fri)", value: "every_weekday" },
  { label: "Every other day", value: "every_other_day" },
  { label: "Weekly", value: "weekly" },
  { label: "Every other week", value: "every_other_week" },
  { label: "Monthly", value: "monthly" },
  { label: "Annually", value: "annually" },
  { label: "Custom", value: "custom" },
];

const CUSTOM_RECURRENCE_RATES = [
  { label: "Hour(s)", value: "hours" },
  { label: "Day(s)", value: "days" },
  { label: "Week(s)", value: "weeks" },
  { label: "Month(s)", value: "months" },
  { label: "Year(s)", value: "years" },
];

const WEEKDAY_MAPPING = [
  { value: 0, label: "S" },
  { value: 1, label: "M" },
  { value: 2, label: "T" },
  { value: 3, label: "W" },
  { value: 4, label: "T" },
  { value: 5, label: "F" },
  { value: 6, label: "S" },
];

const RecurrenceTaskContext = createContext();

const RecurrenceSelector = (props) => {
  const [isRecurringTask, setIsRecurringTask] = useState(true);
  const [selectedRecurrenceRate, setSelectedRecurrenceRate] = useState("Daily");
  const [selectedCustomRecurrenceRate, setSelectedCustomRecurrenceRate] =
    useState(1);
  const [selectedCustomRecurrenceType, setSelectedCustomRecurrenceType] =
    useState("Hours");
  const [taskStartDate, setTaskStartDate] = useState();
  const [taskEndDate, setTaskEndDate] = useState();
  const [selectedWeekdays, setSelectedWeekdays] = useState([]);

  useEffect(() => {
    const {
      type_of_task,
      recurrence_rate,
      custom_recur_frequency_interval,
      custom_recur_frequency_number,
      repeat_on,
      recurrence_start_date,
      recurrence_end_date,
    } = props;

    setIsRecurringTask(type_of_task !== null);
    setSelectedRecurrenceRate(recurrence_rate);
    setSelectedCustomRecurrenceType(custom_recur_frequency_interval);
    setSelectedCustomRecurrenceRate(custom_recur_frequency_number);
    setTaskStartDate(recurrence_start_date);
    setTaskEndDate(recurrence_end_date);
    setSelectedWeekdays(repeat_on || []);
  }, []);

  const recurringTypeOnChange = (event) => {
    setIsRecurringTask(event.target.value === "recurring");
  };

  const { controller_action: controllerAction } = props;
  return (
    <RecurrenceTaskContext.Provider
      value={{
        selectedRecurrenceRate,
        setSelectedRecurrenceRate,
        selectedCustomRecurrenceRate,
        setSelectedCustomRecurrenceRate,
        selectedCustomRecurrenceType,
        setSelectedCustomRecurrenceType,
        selectedWeekdays,
        setSelectedWeekdays,
        taskStartDate,
        setTaskStartDate,
        taskEndDate,
        setTaskEndDate,
      }}
    >
      <div className="recurrence-selector">
        <div className="row">
          <label className="label">Task Recurrence*</label>
          <div className="select is-rounded row">
            <select
              name="task[task_type_selection]"
              onChange={recurringTypeOnChange}
              disabled={controllerAction != "new"}
            >
              <option value="one time" selected={!isRecurringTask}>
                One time
              </option>
              <option value="recurring" selected={isRecurringTask}>
                Recurring
              </option>
            </select>
          </div>

          {isRecurringTask && <RecurringTaskConfigurationContainer />}
        </div>
      </div>
    </RecurrenceTaskContext.Provider>
  );
};

const RecurringTaskConfigurationContainer = () => {
  const {
    selectedRecurrenceRate,
    setSelectedRecurrenceRate,
    taskStartDate,
    taskEndDate,
    setTaskStartDate,
    setTaskEndDate,
  } = useContext(RecurrenceTaskContext);

  return (
    <>
      <div className="row">
        <label className="label">Recurrence Rate*</label>
        <div className="recurrence-rate-options">
          {RECURRENCE_RATES.map((recurrenceRate) => {
            <div
              className="recurrence-rate-selector"
              key={recurrenceRate.value}
            >
              <input
                type="radio"
                name="task[recurrence_rate"
                value={recurrenceRate.value}
                id={recurrenceRate.label}
                checked={selectedRecurrenceRate === recurrenceRate.value}
                onChange={() => setSelectedRecurrenceRate(recurrenceRate.value)}
              />
            </div>;
          })}
        </div>
      </div>
    </>
  );
};

export default RecurrenceSelector;
