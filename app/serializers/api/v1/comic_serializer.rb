class Api::V1::ComicSerializer < ActiveModel::Serializer
  attributes :id, :name, :volume, :updated_at

  belongs_to :user
end
