module Spree
  module OpenAi
    class FineTunes
      attr_accessor :client

      def initialize
        @client = OpenAI::Client.new
      end

      def completions(text_prompt)
        response = client.completions(
          parameters: {
            model: SpreeVirtualMentor::Config[:fine_tuned_model],
            prompt: text_prompt,
            "temperature": 0.7,
            "max_tokens": 256,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0
          }
        )

        return JSON.parse(response.body).merge('status' => 'success') if response.success?

        { 'status' => 'errors' }
      end

      def lists
        response = client.finetunes.list

        return JSON.parse(response.body).merge('status' => 'success') if response.success?

        { 'status' => 'errors' }
      end

      def model_list
        response = client.models.list

        return JSON.parse(response.body).merge('status' => 'success') if response.success?

        { 'status' => 'errors' }
      end

      def file_upload(file_path)
        response = client.files.upload(parameters: { file: file_path, purpose: 'fine-tune' })

        return { 'status' => 'errors' } unless response.success?

        parse_response = JSON.parse(response.body)

        create_finetunes_response = finetunes_create(parse_response['id'])
        return create_finetunes_response.merge('status' => 'success') if create_finetunes_response.success?

        { 'status' => 'errors' }
      end

      private

      def finetunes_create(file_id)
        client.finetunes.create(
          parameters: {
            training_file: file_id,
            model: SpreeVirtualMentor::Config[:custom_model]
          }
        )
      end
    end
  end
end
