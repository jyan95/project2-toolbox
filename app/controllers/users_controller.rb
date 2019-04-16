class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def new_tool
    @user = User.find(params[:id])
    @categories = Category.all
    # @tool = Tool.new
    # @user_tool = UserTool.new
  end

  def create_tool
    user = User.find(params[:id])
    user.add_user_tool_params(user_tool_params, tool_params, category_id)

    redirect_to tools_path
  end

  def user_tool
    @instance = UserTool.find(params[:id])
  end

  private

  def get_instance
    @instance = User.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name)
  end

  def user_params
    params.require(:user).permit(:username, :password, :name, :phone)
  end

  def user_tool_params
    params.require(:user_tool).permit(:cost, :description, :image, :tool_id)
  end

  def category_id
    params.require(:user).permit(:user_tools)
  end
end
