class IdeasController < ApplicationController
  def index
    @idea = Idea.all
    if params[:category_name]
      @category= Category.joins(:ideas).select('categories.id,categories.name as "category",ideas.body').order('categories.id').all      
      render json: {"data":@category.where(name:"#{params[:category_name]}")}
    else
      @category= Category.joins(:ideas).select('categories.id,categories.name as "category",ideas.body').order('categories.id').all
      render json: {"data":@category}
    end
  end

  def create  

    result = 0

    @category = Category.new(name:params[:category_name])
    
    if check_distinct_category(@category["name"])
      #"category_nameが重複している場合の処理"
      category_id = check_distinct_category(@category["name"])["id"]
      @idea = Idea.new(category_id:category_id,body:idea_params["body"])
      
      @idea.save! rescue result = 422
      result = 201 
    else
      #"category_nameが重複していない場合の処理"
      
      @category.save! rescue result = 422
      result = 201 
      
      category_id = check_distinct_category(@category["name"])["id"]
      @idea = Idea.new(category_id:category_id,body:idea_params["body"])
      
      @idea.save! rescue result = 422
      result = 201 
    end

    render json: {status: result}
  end


  private
  def check_distinct_category(category_name)
    Category.all.find {|category| category[:name] == params[:category_name]}
  end


  def idea_params
    params.require(:idea).permit(:body)
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
