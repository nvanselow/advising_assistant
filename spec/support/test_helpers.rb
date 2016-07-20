def expect_json_response(response, status_code)
  expect(response.content_type).to eq('application/json')
  expect(response).to have_http_status(status_code)
end

def parse_json(response, status_code = :ok)
  expect_json_response(response, status_code)
  JSON.parse(response.body)
end
