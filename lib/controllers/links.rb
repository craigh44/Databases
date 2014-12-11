
post '/links' do
  user_id = current_user.id
  title = params["title"]
  # tags = params["tags"].split(" ").map{|tag| 
  # 	Tag.first_or_create(:text => tag)}
  Link.create(:url => params["url"], :title => title, :user_id => user_id  )
  redirect to('/')
end