class IdeasController < ApplicationController
  def index
    if !check_duplicate_category(params[:category_name]) && !params[:category_name].blank?
      render raise ActionController::RoutingError, 'Not Found'
    elsif params[:category_name]
      @category = Category.joins(:ideas).select('categories.id,categories.name as "category",ideas.body').order('categories.id').all
      render json: { "data": @category.where(name: params[:category_name].to_s) }
    else
      @category = Category.joins(:ideas).select('categories.id,categories.name as "category",ideas.body').order('categories.id').all
      render json: { "data": @category }
    end
  end

  def create
    result = 0

    @category = Category.new(name: params[:category_name])

    if check_duplicate_category(@category['name'])
     
      category_id = check_duplicate_category(@category['name'])['id']
      @idea = Idea.new(category_id: category_id, body: idea_params['body'])

      begin
        @idea.save!
        result = 201
      rescue StandardError
        render status: 422
      end

    else

      begin
        @category.save!
        result = 201
      rescue StandardError
        render status: 422
      end


      category_id = check_duplicate_category(@category['name'])['id']
      @idea = Idea.new(category_id: category_id, body: idea_params['body'])

      begin
        @idea.save!
        result = 201
      rescue StandardError
        render status: 422
      end

    end

    render status: result
  end

  private

  def check_duplicate_category(_category_name)
    Category.all.find { |category| category[:name] == params[:category_name] }
  end

  def idea_params
    params.require(:idea).permit(:body)
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def check_save(model)
    begin
      model.save!
      result = 201
    rescue StandardError
      render status: 422
    end    
  end
end
