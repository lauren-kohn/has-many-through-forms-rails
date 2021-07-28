class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories

  # This method is a customized version of what is created by
  # accepts_nested_attributes_for. It adds functionality by
  # looking for a category before creating one to avoid the
  # creation of duplicates.

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.post_categories.build(category: category)
      # self.categories << category
      # categories<< is a method created by has_many
    end
  end

end
