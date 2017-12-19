# == Schema Information
#
# Table name: f1_households
#
#  id                          :integer          not null, primary key
#  uri                         :string
#  old_id                      :integer
#  h_code                      :string
#  household_name              :string
#  household_sort_name         :string
#  household_first_name        :string
#  last_security_authorization :datetime
#  last_activity_date          :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class F1::Household < F1::Base

  has_many :people, class_name: F1::Person.name
  has_many :addresses, class_name: F1::Address.name
  has_many :communications, class_name: F1::Communication.name

  def self.base_route
    '/households'
  end

  def self.f1_attribute_map
    {
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      self.fetch_attributes('/search', {createdDate: '1975-01-01'})
    else
      begin
        self.column_names
      rescue
        self.fetch_attributes('/search', {createdDate: '1975-01-01'})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    super "/search", {createdDate: '1975-01-01'}.merge(data), max_pages
  end

  # SHOW IDs
  # Dimoulis 31219451

  # Total Records
  # 7/27/2017  17,826

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    household = contact_model()
    if !household.valid? || !household.save
      raise "Invalid Contact Model\nF1::Household: #{self.inspect}\nCIVICRM::Contact: #{contact.errors.inspect}"
    end

    prev_id = prev_id_model(household)
    if !prev_id.valid? || !prev_id.save
      raise "Invalid VineContactPrevId Model\nCIVICRM::Contact: #{contact.inspect}\nPrevId: #{prev_id.inspect}"
    end

    relationships.each do |rel|
      if !rel.valid? || !rel.save
        raise "Invalid relationship model\n#{rel.errors.inspect}\n"
      end
    end
  end

  def contact_model
    CIVICRM::Contact.new(
      :contact_type => "Household",
      :contact_sub_type => "Family",
      :sort_name => self.household_sort_name,
      :display_name => self.household_name,
      :preferred_mail_format => 'Both', # Every record appears to have this
      :communication_style_id => nil,
      :email_greeting_id => nil,
      :email_greeting_custom => nil,
      :email_greeting_display => nil,
      :addressee_id => 1,
      :addressee_custom => nil,
      :addressee_display => nil,
      :household_name => self.household_name,
      :created_date => self.created_at,
      :modified_date => self.updated_at
    )
  end

  # Pass in a created contact model to associate with this F1 model
  def prev_id_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    CIVICRM::VineContactPrevId.new(
      contact_id: contact.id,
      f1_id: self.id
    )
  end

  # Join the relationships of all the people in the household
  def relationships
    rels = []
    # Get the types
    head_type = F1::HouseholdMemberType.where(name: 'Head').take
    spouse_type = F1::HouseholdMemberType.where(name: 'Spouse').take
    child_type = F1::HouseholdMemberType.where(name: 'Child').take

    # Get the individuals in each part
    f1_head = self.people.where(household_member_type_id: head_type.id).take
    if f1_head.present?
      prev_id = CIVICRM::VineContactPrevId.where(f1_id: f1_head.id).take
      if prev_id.present?
        head = CIVICRM::Contact.where(id: prev_id.contact_id).take
      end
    end

    f1_spouse = self.people.where(household_member_type_id: spouse_type.id).take
    if f1_spouse.present?
      prev_id = CIVICRM::VineContactPrevId.where(f1_id: f1_spouse.id).take
      if prev_id.present?
        spouse = CIVICRM::Contact.where(id: prev_id.contact_id).take
      end
    end

    prev_id = CIVICRM::VineContactPrevId.where(f1_id: self.id).take
    if prev_id.present?
      household = CIVICRM::Contact.where(id: prev_id.contact_id).take
    end

    children = []
    f1_children = self.people.where(household_member_type_id: child_type.id)
    f1_children.each do |f1_child|
      prev_id = CIVICRM::VineContactPrevId.where(f1_id: f1_child.id).take
      if prev_id.present?
        child = CIVICRM::Contact.where(id: prev_id.contact_id).take
        children.push child
      end
    end

    # Get relationships
    # head - a    household - b
    head_household = CIVICRM::RelationshipType.where(id: 6).take
    # child - a   parent - b
    child_parent = CIVICRM::RelationshipType.where(id: 1).take
    # spouse - a/b
    spouse_rel = CIVICRM::RelationshipType.where(id: 2).take
    # sibling - a/b
    sibling = CIVICRM::RelationshipType.where(id: 3).take
    # individual - a      household - b
    member_household = CIVICRM::RelationshipType.where(id: 7).take

    # Head relationship to household
    if head.present?
      hr = CIVICRM::Relationship.new(
        contact_id_a: head.id,
        contact_id_b: household.id,
        relationship_type_id: head_household.id
      )
      rels.push hr
      # puts "HEAD to HOUSE\n"
    end

    # Spouse relationships
    if spouse.present?
      # belongs to household
      sr = CIVICRM::Relationship.new(
        contact_id_a: spouse.id,
        contact_id_b: household.id,
        relationship_type_id: member_household.id
      )
      rels.push sr
      # puts "SPOUSE to HOUSE\n"
      # Add spouse relationships if head is present
      if head.present?
        shr = CIVICRM::Relationship.new(
          contact_id_a: head.id,
          contact_id_b: spouse.id,
          relationship_type_id: spouse_rel.id
        )
        rels.push shr
        # puts "HEAD to SPOUSE\n"
      end
    end

    # child relationships
    if children.length > 0
      chlds = children.to_a.dup
      # Add to household
      children.each do |child|
        cr = CIVICRM::Relationship.new(
          contact_id_a: child.id,
          contact_id_b: household.id,
          relationship_type_id: member_household.id
        )
        rels.push cr
        # puts "CHILD to HOUSE\n"

        # add to parents
        if head.present?
          chr = CIVICRM::Relationship.new(
            contact_id_a: child.id,
            contact_id_b: head.id,
            relationship_type_id: child_parent.id
          )
          rels.push chr
          # puts "HEAD to CHILD\n"
        end

        # add spouse to parents
        if spouse.present?
          csr = CIVICRM::Relationship.new(
            contact_id_a: child.id,
            contact_id_b: spouse.id,
            relationship_type_id: child_parent.id
          )
          rels.push csr
          # puts "SPOUSE to CHILD\n"
        end

        # remove current child from list
        chlds.delete(child)
        chlds.each do |sib|
          sibr = CIVICRM::Relationship.new(
            contact_id_a: child.id,
            contact_id_b: sib.id,
            relationship_type_id: sibling.id
          )
          rels.push sibr
          # puts "SIB to SIB\n"
        end
      end
    end

    rels
  end
end
