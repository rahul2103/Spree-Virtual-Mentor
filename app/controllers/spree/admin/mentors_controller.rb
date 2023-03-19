module Spree
  module Admin
    class MentorsController < Spree::Admin::BaseController
      def completions
        text_prompt = params[:mentor][:message] || 'Hello !'

        response = Spree::OpenAi::FineTunes.new.completions(text_prompt)

        data = if response['status'] == 'success'
                 { message: response["choices"].map { |c| c["text"] } }
               else
                 { message: 'Something went wrong, pls try again.' }
               end

        respond_to do |format|
          format.json { render json: data.to_json }
        end
      end

      def chat; end

      def model_list
        @model_lists = Spree::OpenAi::FineTunes.new.model_list
      end

      def set_completions_model
        SpreeVirtualMentor::Config[:fine_tuned_model] = params[:completions_model]

        redirect_to fine_tunes_lists_admin_mentors_url
      end


      def set_custom_model
        SpreeVirtualMentor::Config[:custom_model] = params[:custom_model]

        redirect_to model_list_admin_mentors_url
      end

      def fine_tunes_lists
        @fine_tunes_lists = Spree::OpenAi::FineTunes.new.lists
      end

      def create_fine_tunes
        file_path = params[:file].path

        if File.exist?(file_path)
          @file_upload_response = Spree::OpenAi::FineTunes.new.file_upload(file_path)

          if @file_upload_response['status'] == 'success'
            flash[:success] = 'Successfully Uploaded !'
          else
            flash[:error] = 'Something went wrong, pls try again!'
          end
        else
          flash[:error] = 'File Not Found'
        end

        redirect_to fine_tunes_lists_admin_mentors_url
      end
    end
  end
end
