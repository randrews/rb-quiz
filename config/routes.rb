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

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
