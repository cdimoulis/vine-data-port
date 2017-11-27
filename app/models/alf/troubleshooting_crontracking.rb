class ALF::TroubleshootingCrontracking < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :cron_tracking_id, :cron_tracking_date, :cron_tracking_records, :cron_tracking_updated, :cron_tracking_inserted, :cron_tracking_runtime

  # Name to be sent in request to API
  def self.alf_name
    'troubleshooting_crontracking'
  end

  # Primary id key for record
  def self.id_attribute
    'cron_tracking_id'
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

end
