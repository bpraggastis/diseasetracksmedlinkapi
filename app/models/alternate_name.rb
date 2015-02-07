class AlternateName < ActiveRecord::Base

  include Searchable

  has_one :synonym
  has_one :medical_condition, through: :synonyms

  def self.search(query)
    response = __elasticsearch__.search(
    {
      query: {
        fuzzy_like_this_field: {
          name: {
            like_text: query
          }
        }
      }
    })
    return response
  end
end
