def expect_json_response(response)
  expect(response.content_type).to eq('application/json')
  expect(response).to have_http_status(:ok)
end

def parse_json(response)
  expect_json_response(response)
  JSON.parse(response.body)
end
