import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import AdviseeSearch from './components/AdviseeSearch';
import UpcomingMeetings from './components/UpcomingMeetings';
import Notes from './components/Notes';
import Meetings from './components/Meetings';
import MeetingTime from './components/MeetingTime';
import DateTimePicker from './components/DateTimePicker';
import GraduationPlan from './components/GraduationPlan';

$(function() {
  let adviseeSearch = document.getElementById('advisee-search');

  if(adviseeSearch){
    ReactDOM.render(
      <AdviseeSearch />,
      adviseeSearch
    );
  }

  let upcomingMeetings = document.getElementById('upcoming-meetings');

  if(upcomingMeetings){
    ReactDOM.render(
      <UpcomingMeetings />,
      upcomingMeetings
    );
  }

  let adviseeNotes = document.getElementById('advisee-notes');

  if(adviseeNotes){
    let adviseeId = $('#advisee-data').data('id');

    ReactDOM.render(
      <Notes noteableType="advisees"
             noteableId={adviseeId}
             controller="advisee_notes" />,
      adviseeNotes
    );
  }

  let adviseeMeetings = document.getElementById('advisee-meetings');

  if(adviseeMeetings){
    let adviseeId = $('#advisee-data').data('id');

    ReactDOM.render(
      <Meetings adviseeId={adviseeId} />,
      adviseeMeetings
    );
  }

  let meetingNotes = document.getElementById('meeting-notes');

  if(meetingNotes){
    let meetingId = $('#meeting-data').data('id');

    ReactDOM.render(
      <Notes noteableType="meetings"
             noteableId={meetingId}
             controller="meeting_notes" />,
      meetingNotes
    );
  }

  let meetingTime = document.getElementById('meeting-time');

  if(meetingTime){
    let meetingStart = $('#meeting-data').data('start');
    let meetingEnd = $('#meeting-data').data('end');

    ReactDOM.render(
      <MeetingTime startTime={meetingStart} endTime={meetingEnd} />,
      meetingTime
    );
  }

  let editMeetingStartTime = document.getElementById('edit-meeting-start-time');

  if(editMeetingStartTime){
    let meetingStartTime = $('#edit-meeting-start-time-data').data('start');

    ReactDOM.render(
      <DateTimePicker name="meeting[start_time]"
                      initialValue={meetingStartTime}
                      id="meeting_start_time" />,
      editMeetingStartTime
    );
  }

  let graduationPlan = document.getElementById('graduation-plan');

  if(graduationPlan){
    let gradPlanData = $('#graduation-plan-data');
    let planId = gradPlanData.data('id');
    let planName = gradPlanData.data('name');

    ReactDOM.render(
      <GraduationPlan planId={planId} planName={planName} />,
      graduationPlan
    );
  }
});
