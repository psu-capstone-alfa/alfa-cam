require 'flowdock'

begin
  flow = Flowdock::Flow.new(
    :api_token => `git config flowdock.token`,
    :external_user_name => 'CIJoe')
rescue
  flow = nil
end


namespace :ci do
  namespace :master do
    env = "Master"
    task :build do
      #flow.push_to_chat(:content => "#{env} building...", :tags => [:master, :success])
    end
    task :success do
      flow.push_to_chat(:content => "#{env} build success.", :tags => [:master, :success])
    end
    task :fail do
      flow.push_to_chat(:content => "#{env} build FAILED!", :tags => [:master, :FAILED])
    end
  end
  namespace :staging do
    env = "Staging"
    task :build do
      #flow.push_to_chat(:content => "#{env} building...", :tags => [:master, :success])
    end
    task :success do
      flow.push_to_chat(:content => "#{env} build success.", :tags => [:master, :success])
    end
    task :fail do
      flow.push_to_chat(:content => "#{env} build FAILED!", :tags => [:master, :FAILED])
    end
    namespace :deploy do
      task :begin do
        flow.push_to_chat(:content => "#{env} deploying...", :tags => [:master, :success])
      end
      task :success do
        flow.push_to_chat(:content => "#{env} deploy success.", :tags => [:master, :success])
      end
      task :fail do
        flow.push_to_chat(:content => "#{env} deploy FAILED!", :tags => [:master, :FAILED])
      end
    end
  end
end

