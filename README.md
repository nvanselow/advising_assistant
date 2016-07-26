# Advising Assistant

[![Build Status](https://codeship.com/projects/fe056ee0-2f4f-0134-7f62-4a25dba64f1f/status?branch=master)](https://codeship.com/projects/163891)
[![Coverage Status](https://coveralls.io/repos/github/nvanselow/advising_assistant/badge.svg?branch=master)](https://coveralls.io/github/nvanselow/advising_assistant?branch=master)

Demo Site: https://advising-assistant.herokuapp.com/

## About

Advising Assistant is a web application that helps college advisors manage
the ever increasing number of advisees they must supervise.

The web app was built with Ruby on Rails for the backend. Most of the front-end
is composed of various React components that are reusable throughout the site.
I also wrapped some of the Materialize CSS parts in to React components or plain
ES6 javascript classes for easier integration throughout the app.

Photos are uploaded to, and hosted on, and Amazon S3 bucket using CarrierWave
and Fog.

I integrated the Google Calendar API and the Microsoft Office 365 API to allow
users to add meetings to their Google or Outlook calendars.

## Why Did I Build Advising Assistant?

Before deciding to pursue a full-time career in development, I was an assistant
professor. I had large Excel files and Word documents which were my attempt
to organize over 100 advisees. I built this app to solve the problem I faced
as a professor, program director, and academic advisor. I also thought this
would be an interesting problem to solve because it would involve interacting
with many third party APIs.

## Features

### Search Advisees

Quickly search for advisees. Advisees are filtered as you type.

### Add Notes and Meetings

Quickly add notes about an advisee's progress or schedule a meeting with
an advisee.


### Add Meetings to Google Calendar or Microsoft Outlook (Office 365)

You can link your account to a Google or Microsoft Office 365 account (or both!)
so that you can quickly export meetings you schedule in the app to your calendar
and send invites to your advisee about the meeting.

### Edit Notes Inline

Quickly edit notes by editing inline without a page refresh.

### Send Summary Emails

After taking notes during a meeting, send a summary email to your advisee
that reviews what was discussed.

### Download
```
git clone https://github.com/nvanselow/advising_assistant.git
cd advising_assistant
bundle install
rake db:create db:migrate
npm start
```
(in a separate tab: `rails s` to start the server)

Check out the .env.example file for keys you need to use all features.
