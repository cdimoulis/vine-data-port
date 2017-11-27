class ALF::PcmsContenthistory < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :HistoryID, :HistoryContentID, :HistoryUserID, :HistoryValue, :HistoryGroup, :HistoryReference, :HistoryDate, :ContentPageName, :ContentPageSetParentID, :ContentPageSetOrder, :ParentID

  # Name to be sent in request to API
  def self.alf_name
    'pcms2_contenthistory'
  end

  # Primary id key for record
  def self.id_attribute
    'HistoryID'
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
