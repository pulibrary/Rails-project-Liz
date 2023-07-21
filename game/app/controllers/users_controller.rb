class UsersController < ApplicationController
  def index
    render "index"
  end

  def list_users
    @users = User.joins(:scores)
                  .select("users.name, users.username, subquery.highest_score as highest_score")
                  .joins(
                    <<~SQL
                      LEFT JOIN (
                        SELECT user_id, MAX(score) AS highest_score
                        FROM scores
                        GROUP BY user_id
                      ) AS subquery ON users.id = subquery.user_id
                      SQL
                  )
                  .order("users.name ASC")
    render "/users/list_users"
  end

  def scoreboard
    # By using GROUP BY users.id, we ensure that we get one row for
    # each unique user (i.e., one row per users.id), and the MAX(scores.score) 
    # function will give us the highest score for each user.
    @users = User.joins("LEFT JOIN scores on users.id = scores.user_id")
                 .select('users.name, scores.score as highest_score, scores.created_at as datetime')
                 .where("scores.score = (SELECT MAX(score) FROM scores WHERE user_id = users.id)")
                 .order('highest_score DESC, scores.created_at DESC')
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

    if @user.save 
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      render :create_account, status: :unprocessable_entity
    end
  end

  def access_profile
    p "in access profile method"
    @user = User.find(params[:user_id])
    p @user
    if @user
      @data = Score.joins(:user) # due to association, "joins" matches id automatically.
                    .select("users.name, users.username, scores.score, scores.created_at")
                    .where("scores.score = (SELECT MAX(score) FROM scores where user_id = users.id)")
                    .order("scores.score DESC")
                    .limit(10)

      render "users/profile"
    else
      render json: { status: "error", message: "Invalid username or password" }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render "users/profile"
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation)
    end

end