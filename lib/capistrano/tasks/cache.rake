# frozen_string_literal: true

require 'time'

namespace :cache do
  namespace :clean do
    task :monthly do
      on roles(:app) do
        period = fetch(:cache_clean_period, 2_629_746) # month
        data_file_name = File.join(deploy_to, 'cache_last_cleaned_on')

        last_cleaned_on = fetch_last_cleaned_on(data_file_name)
        next_clean_on = last_cleaned_on ? last_cleaned_on + period : nil

        if next_clean_on && next_clean_on > Time.now.utc
          output.info "skipping untill #{next_clean_on}"
        else
          output.info 'time to clean'
          invoke 'cache:clean:tmp'
          execute "echo \"#{Time.now.utc}\" > #{data_file_name}"
        end
      end
    end

    def fetch_last_cleaned_on(data_file_name)
      Time.parse(capture(:cat, data_file_name)).utc
    rescue SSHKit::Command::Failed => e
      if e.message.include?('No such file or directory')
        output.info "No #{data_file_name} yet (will be created after run)"
        nil
      else
        raise e
      end
    rescue ArgumentError
      nil
    end

    desc 'remote rake tmp:cache:clear'
    task :tmp do
      on roles(:app) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            rake 'tmp:clear'
          end
        end
      end
    end

    desc 'Cleans directory with cached pages'
    task :pages do
      on roles(:web) do
        dir_name = fetch(:chached_pages_dir, 'public/cached_pages')
        current_path = File.join(shared_path, dir_name)
        trash_path = File.join(shared_path, "#{dir_name}_trash")
        mv = "mv #{current_path} #{trash_path}"
        mkdir = "mkdir -p #{current_path}"
        rm = "rm -r #{trash_path}"
        execute [mv, mkdir, rm].join(' && ')
      end
    end
  end
end
