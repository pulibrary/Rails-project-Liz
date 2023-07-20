class UsersController < ApplicationController
  def index
    render "index"
  end

  def scoreboard
    # By using GROUP BY users.id, we ensure that we get one row for
    # each unique user (i.e., one row per users.id), and the MAX(scores.score) 
    # function will give us the highest score for each user.
    @users = User.joins("LEFT JOIN scores on users.id = scores.user_id")
                 .select('users.name, scores.score as highest_score, scores.created_at as datetime')
                 .where("scores.score = (SELECT MAX(score) FROM scores WHERE user_id = users.id)")
                 .order('highest_score DESC')
                 .limit(10)
    render "users/scoreboard"
  end

  # def show
  #   @user = User.find(params[:id])
  # end

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

  def profile
    @user = User.find(params[:id])
    render "users/profile"
  end

  def edit_profile
    respond_to do |format|
      format.js { render 'edit'}
    end
  end 

  def auth

     # Get the username and password from the request parameters
     username = params[:username]
     password = params[:password]
 
     # Find the user with the provided username and password
     authenticated_user = User.find_by(username: username, password: password)
 
     if authenticated_user
       # Authentication succeeded, render the user's profile
       respond_to do |format|
         format.js { render 'profile', user: authenticated_user }
       end
     else
        # Authentication failed, return an error
        respond_to do |format|
          format.js { render js: "alert('Invalid username or password.');", status: :unprocessable_entity }
        end
      end
    end

  def access_profile
    @user = User.find_by(username: params[:username])
    @scores = Score.joins(@user) # due to association, "joins" matches id automatically.
                    .select("score.*")
                    .where("scores.score = (SELECT MAX(score) FROM scores where user_id = users.id)")
                    .order("score: :desc")
                    .limit(10)

    render "users/profile"
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