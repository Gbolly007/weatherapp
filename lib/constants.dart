import 'package:flutter/material.dart';

const todayText = "Today";
const weeklyText = "Weekly";
const bottomNavColor = Color(0xFFE7E7E8);
const activecolor = Color(0xFF557DBF);
const kGeneralColor = Color(0xFF738D97);
const feelslikeText = "Feels like";
const weatherDataStyle=TextStyle(
  color: Color(0xFFFF898787),
  fontSize: 13,
  fontFamily: 'Quicksand',
);
const weatherValueStyle = TextStyle(
  color: Color(0xFFFF747272),
  fontFamily: 'Quicksand',
  fontSize: 13.0,
  fontWeight: FontWeight.bold,
);
const humidityText="Humidity";
const windText = "Wind";
const pressureText = "Pressure";

const fontfamilytext="Quicksand";

String dte() {

  DateTime date = DateTime.now();

  var month = date.month;
  var weekday = date.weekday;
  String day = date.day.toString();

  String monthText="";

  String dayText = "";

  switch(month){
    case 1:
      monthText= "January";
      break;
    case 2:
      monthText= "Februrary";
      break;
    case 3:
      monthText= "March";
      break;
    case 4:
      monthText= "April";
      break;
    case 5:
      monthText= "May";
      break;
    case 6:
      monthText= "June";
      break;
    case 7:
      monthText= "July";
      break;
    case 8:
      monthText= "August";
      break;
    case 9:
      monthText= "September";
      break;
    case 10:
      monthText= "October";
      break;
    case 11:
      monthText= "November";
      break;
    case 12:
      monthText= "December";
      break;
    default:
      monthText= "";
  }

  switch(weekday) {
    case 1:
      dayText = "Monday";
      break;
    case 2:
      dayText = "Tuesday";
      break;
    case 3:
      dayText = "Wednesday";
      break;
    case 4:
      dayText = "Thursday";
      break;
    case 5:
      dayText = "Friday";
      break;
    case 6:
      dayText = "Saturday";
      break;
    case 7:
      dayText = "Sunday";
      break;
    default:
      dayText= "";
  }


  return dayText +" "+  monthText+" "+day;
}

const apiKey = "b0ed477afabe3883cd633f39b7e03577";
const forecastColor = Color(0xFF293651);
const shareText = "Share";