helpers do

  def post_score(post)
    downvote = post.post_votes.where('vote_status = ?',false).count
    upvote = post.post_votes.where('vote_status = ?',true).count
    @post_score = upvote - downvote
    
  end


  def set_user_id
    session[:user_id] = @user.id
  end


  def logged_in?
    session[:user_id].present?
  end

  def current_user
    if session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
    end
  end
end