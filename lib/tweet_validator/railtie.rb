module TweetValidator
  class Railtie < Rails::Railtie
    # rails loading hook
    ActiveSupport.on_load(:before_initialize) do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:include, TweetValidator)
      end
    end
  end
end
