class Post 
  attr_accessor :posting_id,
              :post_link,
              :post_date, 
              :name,
              :description

  def initialize(posting_id:, post_link:, post_date:, name:, description:)
    @posting_id = posting_id 
    @post_link = post_link 
    @post_date = post_date
    @name = name 
    @description = description
  end 
end 