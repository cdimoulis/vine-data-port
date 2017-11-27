namespace :alf do
  task build_models: :environment do
    alf_models = [
      {model: "department", alf: "2_department"},
      {model: "program", alf: "3_program"},
      {model: "calendar", alf: "4_calendar"},
      {model: "event_category", alf: "5_event_category"},
      {model: "event", alf: "6_event"},
      {model: "user_group", alf: "access_usergroup"},
      {model: "user_login", alf: "access_userlogin"},
      {model: "event_room", alf: "bridge_event_room"},
      {model: "event_teaching_bible", alf: "bridge_event_teaching_bible"},
      {model: "event_volunteer_time", alf: "bridge_event_volunteer_time"},
      {model: "ignore_duplicates", alf: "bridge_ignore_duplicates"},
      {model: "person_volunteer_status", alf: "bridge_person_volunteer_status"},
      {model: "program_song", alf: "bridge_program_song"},
      {model: "room_position", alf: "bridge_room_position"},
      {model: "sg_attendance_designee", alf: "bridge_sg_attendance_designee"},
      {model: "sg_demographic", alf: "bridge_sg_demographic"},
      {model: "sg_option_question", alf: "bridge_sg_option_question"},
      {model: "sg_report_childcare", alf: "bridge_sg_report_childcare"},
      {model: "staff_position", alf: "bridge_staff_position"},
      {model: "position_category", alf: "bridge_staff_position_category"},
      {model: "teaching_bible", alf: "bridge_teaching_bible"},
      {model: "teaching_series_bible", alf: "bridge_teaching_series_bible"},
      {model: "teaching_series_topic", alf: "bridge_teaching_series_topic"},
      {model: "teaching_topic", alf: "bridge_teaching_topic"},
      {model: "cms", alf: "cms"},
      {model: "display_address", alf: "display_address"},
      {model: "email_log", alf: "email_log"},
      {model: "form_data", alf: "form_data"},
      {model: "form_name", alf: "form_name"},
      {model: "address", alf: "info_address"},
      {model: "church", alf: "info_church"},
      {model: "communication", alf: "info_communication"},
      {model: "email", alf: "info_email"},
      {model: "household", alf: "info_household"},
      {model: "person", alf: "info_person"},
      {model: "person_background", alf: "info_person_background"},
      {model: "phone", alf: "info_phone"},
      {model: "slides", alf: "info_slides"},
      {model: "song", alf: "info_song"},
      {model: "staff", alf: "info_staff"},
      {model: "volunteer_time", alf: "info_volunteer_time"},
      {model: "loading_verses", alf: "loading_verses"},
      {model: "login", alf: "login"},
      {model: "address_type", alf: "menu_address_type"},
      {model: "attendance", alf: "menu_attendance"},
      {model: "bible", alf: "menu_bible"},
      {model: "communication_type", alf: "menu_communication_type"},
      {model: "country", alf: "menu_country"},
      {model: "dow", alf: "menu_dow"},
      {model: "email_type", alf: "menu_email_type"},
      {model: "gender", alf: "menu_gender"},
      {model: "household_position", alf: "menu_household_position"},
      {model: "marital_status", alf: "menu_marital_status"},
      {model: "membership_status", alf: "menu_membership_status"},
      {model: "person_category", alf: "menu_person_category"},
      {model: "person_prefix", alf: "menu_person_prefix"},
      {model: "person_suffix", alf: "menu_person_suffix"},
      {model: "phone_type", alf: "menu_phone_type"},
      {model: "sg_category", alf: "menu_sg_category"},
      {model: "sg_demographics", alf: "menu_sg_demographics"},
      {model: "sg_meeting_type", alf: "menu_sg_meeting"},
      {model: "sg_person_status", alf: "menu_sg_person_status"},
      {model: "sg_question_options", alf: "menu_sg_question_options"},
      {model: "grade", alf: "menu_sg_youth"},
      {model: "song_category", alf: "menu_song_category"},
      {model: "staff_category", alf: "menu_staff_category"},
      {model: "position", alf: "menu_staff_position"},
      {model: "state", alf: "menu_state"},
      {model: "topics", alf: "menu_topics"},
      {model: "volunteer_status", alf: "menu_volunteer_status"},
      {model: "pcms_contenthistory", alf: "pcms2_contenthistory"},
      {model: "pcms_contents", alf: "pcms2_contents"},
      {model: "pcms_toolbardefinitions", alf: "pcms2_toolbardefinitions"},
      {model: "pcms_toolbargroupdefinitions", alf: "pcms2_toolbargroupdefinitions"},
      {model: "pcms_toolbargroups", alf: "pcms2_toolbargroups"},
      {model: "pcms_toolbaroptions", alf: "pcms2_toolbaroptions"},
      {model: "pcms_toolbarpresets", alf: "pcms2_toolbarpresets"},
      {model: "pcms_usergroups", alf: "pcms2_usergroups"},
      {model: "audio_permissions", alf: "reporting_audio_permissions"},
      {model: "baptism", alf: "reporting_baptism"},
      {model: "event_attendance", alf: "reporting_event_attendance"},
      {model: "headcount", alf: "reporting_headcount"},
      {model: "membership_form", alf: "reporting_membership_form"},
      {model: "serving", alf: "reporting_serving"},
      {model: "sg_attendance", alf: "reporting_sg_attendance"},
      {model: "sg_meeting", alf: "reporting_sg_meeting"},
      {model: "sg_questions", alf: "reporting_sg_questions"},
      {model: "unsubmitted_schedule", alf: "reporting_unsubmitted_schedule"},
      {model: "youth_sg_attendance", alf: "reporting_youth_sg_attendance"},
      {model: "youth_sg_meeting", alf: "reporting_youth_sg_meeting"},
      {model: "schedule", alf: "schedule"},
      {model: "schedule_event_checkin", alf: "schedule_event_checkin"},
      {model: "sg_highlight", alf: "sg_highlight"},
      {model: "sg_smallgroup", alf: "sg_smallgroup"},
      {model: "sg_youth", alf: "sg_youth"},
      {model: "teaching_event", alf: "teaching_event"},
      {model: "teaching_individual", alf: "teaching_individual"},
      {model: "teaching_sample", alf: "teaching_sample"},
      {model: "teaching_series", alf: "teaching_series"},
      {model: "temp_storage", alf: "temp_storage"},
      {model: "tmp_event", alf: "tmp_event"},
      {model: "troubleshooting_crontracking", alf: "troubleshooting_crontracking"},
      {model: "troubleshooting_support", alf: "troubleshooting_support"},
      {model: "update_ids", alf: "update_ids"},
      {model: "zipcodes", alf: "zipcodes"}
    ]

    alf_models.each do |obj|
      file_name = "app/models/alf/#{obj[:model]}.rb"
      if FileTest.exist?(file_name)
        puts "\nAlready Exists: #{file_name}\n"
      else
        file = File.open(file_name, 'w')
        file.puts("class ALF::#{obj[:model].classify} < ALF::Base

  # attr_accessor

  # Name to be sent in request to API
  def self.alf_name
    '#{obj[:alf]}'
  end

  # Primary id key for record
  def self.id_attribute

  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {

    }
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {

    }
  end

end"
        )
        file.close();

        puts "\nCreated file: #{file_name}"
      end
    end
  end
end
