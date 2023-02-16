import React, { useState, useContext, useEffect } from "react";

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


class RecurrenceSelector extends React.Component {
  render () {
    return (
      <React.Fragment>
      </React.Fragment>
    );
  }
}

export default RecurrenceSelector
