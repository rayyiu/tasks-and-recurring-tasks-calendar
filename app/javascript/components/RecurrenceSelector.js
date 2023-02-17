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


class RecurrenceSelector extends React.Component {
  render () {
    return (
      <React.Fragment>
      </React.Fragment>
    );
  }
}

export default RecurrenceSelector
