ActionController::Routing::Routes.draw do |map|
  map.root :controller=>"quiz", :action=>"index"

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.start_quiz "/quiz/:short_name", :controller=>"quiz", :action=>"start_quiz"
  map.answer_quiz "/quiz/:short_name/:question_id/:answer_id", :controller=>"quiz", :action=>"answer"
  map.restart_quiz "/quiz/:short_name/restart", :controller=>"quiz", :action=>"restart"
  map.quiz_results "/quiz/:short_name/results", :controller=>"quiz", :action=>"results"
  map.quiz_question "/quiz/:short_name/:question_id", :controller=>"quiz", :action=>"question"

  map.edit_quiz "/edit/:short_name", :controller=>"admin", :action=>"edit_quiz"
  map.edit_results "/edit/:short_name/results", :controller=>"admin", :action=>"edit_results"
  map.edit_questions "/edit/:short_name/questions", :controller=>"admin", :action=>"edit_questions"

  map.show_result "/result/show/:id", :controller=>"admin", :action=>"show_result"
  map.edit_result "/result/edit/:id", :controller=>"admin", :action=>"edit_result"
  map.delete_result "/result/delete/:id", :controller=>"admin", :action=>"delete_result", :method=>:post

  map.admin "/admin", :controller=>"admin"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
