get '/' do
  @posts = Post.all.sort_by &:created_at

  erb :index
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :single_post
end


post '/new_comment/:post_id' do 
  if logged_in?
    Comment.create(:body => params[:body],
                   :user_id => current_user.id,
                   :post_id => params[:post_id])
    redirect to "/posts/#{params[:post_id]}'"
  else
    redirect '/'
  end
end

get '/new_post' do
  erb :new_post
end

post '/new_post' do
  if logged_in?
    @post = Post.create(:title => params[:title],
                        :body => params[:body],
                        :user_id => current_user.id)
    redirect "/posts/#{@post.id}"
  else
    erb :login_signup  
  end
end

post '/post_downvote' do
 if logged_in?
    post = Post.find(params[:post_id])
    user = post.user_id
    PostVote.find_or_create_by_post_id_and_user_id(:vote_status => false,
                                                   :post_id => post.id,
                                                   :user_id => user)
    redirect '/'
  else 
    redirect '/'
  end
end

post '/post_upvote' do
  if logged_in?
    post = Post.find(params[:post_id])
    user = post.user_id
    PostVote.find_or_create_by_post_id_and_user_id(:vote_status => true,
                                                   :post_id => post.id,
                                                   :user_id => user)
    redirect '/'
  else
    redirect '/'
  end 
end








post '/comment_downvote' do
 if logged_in?
    comment = Comment.find(params[:comment_id])
    user = comment.user_id
    CommentVote.find_or_create_by_comment_id_and_user_id(:vote_status => false,
                                                         :comment_id => comment.id,
                                                         :user_id => user)
    redirect '/'
  else 
    redirect '/'
  end
end

post '/comment_upvote' do
  if logged_in?
    comment = Comment.find(params[:comment_id])
    user = comment.user_id
    CommentVote.find_or_create_by_comment_id_and_user_id(:vote_status => true,
                                                         :comment_id => comment.id,
                                                         :user_id => user)
    redirect '/'
  else
    redirect '/'
  end 
end














post '/signup' do
  p params
  @user = User.new(params[:user])
  if @user.save
    set_user_id
    redirect '/'
  else
    puts "*" * 100
    puts "USER DIDN'T SAVE! "
    erb :index
  end
end

post '/login' do
  @user = User.find_by_email(params[:email])
  p @user.password == params[:password]
  if @user.password == params[:password]
    set_user_id
    redirect '/'
  else
    # raise 'no user with that info'
    redirect '/'
  end
end

  # user = User.find_by_email(params[:email])
  # login


get '/login_signup' do
  erb :login_signup
end


get '/logout' do
  session.clear
  redirect '/'
end