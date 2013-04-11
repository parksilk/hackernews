get '/' do
  @posts = Post.all.sort_by &:created_at

  erb :index
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :single_post
end

post '/downvote' do
 if logged_in?
    post = Post.find(params[:post_id])
    user = post.user_id
    PostVote.create(:vote_status => false,
                    :post_id => post.id,
                    :user_id => user)
    redirect '/'
  else 
    redirect '/'
  end
end

post '/upvote' do
  if logged_in?
    post = Post.find(params[:post_id])
    user = post.user_id
    PostVote.create(:vote_status => true,
                    :post_id => post.id,
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