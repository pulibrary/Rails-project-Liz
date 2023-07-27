class UsersController < ApplicationController
  def index
    render "index"
  end

  def list_players
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

    if @user.valid? && @user.save 
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      flash["alert"] = "Unsuccessful account creation. Please contract administrator."
      render :create_account, status: :unprocessable_entity
    end
  end

  def access_profile
    @user = User.find(params[:user_id])
    # Note: can test as follows
    # p "access profile = #{@user.id}"
    # p "name = #{@user.name}"
    @data = User.joins(:scores) # due to association, "joins" matches id automatically.
                  .select("users.name, users.username, scores.score, scores.created_at")
                  .where("user_id = #{@user.id}")
                  .order("scores.score DESC")

    render "users/profile" # ->  has access to instance variables in controller
  end

  def edit 
    @user = User.find(params[:id])
    render "/users/edit_profile", user: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "Updated account information successfully!"
      redirect_to "/users" #same as root_path
    else 
      flash[:alert] = "Unsuccessful account update. Please contact administrator."
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id]) 
    @data = User.joins(:scores) # due to association, "joins" matches id automatically.
                .select("users.name, users.username, scores.score, scores.created_at")
                .where("user_id = #{@user.id}")
                .order("scores.score DESC")

    if @user.destroy
      flash[:notice] = 'Account was successfully deleted!'
      redirect_to root_path
    else
      flash[:alert] = 'Unsuccessful account deletion. Please contact administrator.'
      render :profile, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation)
    end

end