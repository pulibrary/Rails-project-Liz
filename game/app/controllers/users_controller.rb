class UsersController < ApplicationController
  def index
    render "index"
  end

  # By using GROUP BY users.id, we ensure that we get one row for
  # each unique user (i.e., one row per users.id), and the MAX(scores.score) 
  # function will give us the highest score for each user.
  def list_players
    # Note: use instance variables with @ to make it available to view template
    @users = User.joins(
                          <<~SQL
                            LEFT JOIN (
                              SELECT user_id, MAX(score) AS highest_score
                              FROM scores
                              GROUP BY user_id
                            ) AS subquery ON users.id = subquery.user_id
                            SQL
                        )
                  .select("users.name, users.username, subquery.highest_score as highest_score")
                  .order("users.name ASC")
    render "/users/list_players"
  end

  def scoreboard
    @users = User.joins(:scores)
                 .select('users.name, users.username, scores.score as highest_score, scores.updated_at as date')
                 .order('highest_score DESC, scores.updated_at DESC')
                 .limit(10)
    render "users/scoreboard"
  end

  # Render the app/users/create_account.html.erb view.
  def create_account 
    @user = User.new
    render "users/create_account"
  end

  def create
    @user = User.new(user_params)

    if @user.valid? && @user.save 
      flash[:notice] = "Created account successfully!"
      redirect_to root_path
    else
      flash["alert"] = "Unsuccessful account creation."
      render :create_account, status: :unprocessable_entity
    end
  end

  def access_profile
    @user = User.find(params[:user_id])
    @data = User.joins(:scores) # due to association, "joins" matches id automatically.
                  .select("users.name, users.username, scores.score, scores.updated_at as date")
                  .where("user_id = #{@user.id}")
                  .order("scores.score DESC, date DESC")

    render "users/profile" # ->  has access to instance variables in controller
  end

  def edit 
    @user = User.find(params[:id])
    render "/users/edit_profile", user: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "Updated account information successfully!!"
      redirect_to "/users"
    else 
      flash[:alert] = "Unsuccessful account update."
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id]) 

    if @user.destroy
      flash[:notice] = 'Deleted account successfully!'
      redirect_to root_path
    else
      flash[:alert] = 'Unsuccessful account deletion.'
      render :profile, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation)
    end

end