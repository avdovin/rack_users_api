# frozen_string_literal: true

describe App do
  let(:app)      { App::Rack.new }
  let(:response) { app.call(env) }
  let(:body)     { response[2][0] }
  let(:parsed_body) { JSON.parse(body) }

  context '.index' do
    let(:env)      { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/users' } }

    before do
      (1..10).each do |i|
        DB[:users].insert(email: "test_#{i}@gmail.com")
      end
    end

    it 'returns users' do
      expect(parsed_body.count).to eq 10
      expect(parsed_body.last).to include('id' => 10, 'email' => 'test_10@gmail.com')
    end
  end

  # context '.create' do
  #   let(:json_payload) { { "email": 'john@gmail.com' } }
  #   let(:env) do
  #     {
  #       'REQUEST_METHOD' => 'POST',
  #       'PATH_INFO' => '/users',
  #       'RAW_POST_DATA' => StringIO.new(JSON.generate(json_payload)),
  #       'CONTENT_TYPE' => 'application/json'
  #     }
  #   end

  #   it 'returns users' do
  #     raise parsed_body.inspect
  #   end
  # end
end
