class FakeMicrosoftService
  def make_api_call(_method, _url, _token)
    # The "___" obscures tokens
    "{\"@odata.context\":\"https://outlook.office.com/api/v2.0/$metadata#Me/"\
    "Calendars\",\"value\":[{\"@odata.id\":\"https://outlook.office.com/api/"\
    "v2.0/Users('________-5fbe-4d7f-b7dc-______________a9f2e366-f501-4d69-ae0d"\
    "-e623e4a8f728')/Calendars('______________________WUtNDcwOS1iYTFiLTAzYjExO"\
    "___wBGAAAAAACXwb7j7ibTQr908zfjeqQyBwBBl70jVEFe_________________AAAAAAEGAA"\
    "___eQrRb40GYw_yuAAAAISU8AAA=')\",\"Id\":\"calendar_1\",\"Name\":\"Calen"\
    "dar\",\"Color\":\"Auto\",\"ChangeKey\":\"change_key_1\"},{\"@odata."\
    "id\":\"https://outlook.office.com/api/v2.0/Users('e___a60080@a9f2e366-f5"\
    "01-4d________________________')/Calendars('____iYTFiLTAzYjExOTFhMjQ5MwBG"\
    "AAAAAA______________AAAAEGAABBl70jVEFeQrRb40GYw_yuAAAAISVBAAA=')\",\"Id\""\
    ":\"calendar_2\",\"Name\":\"United Statesholidays\",\"Color\":\"Auto\",\"C"\
    "hangeKey\":\"change_key_2\"},{\"@odata.id\":\"https://outlook.office.com/"\
    "api/v2.0/Users('ea9_______________________________________________f728')/"\
    "Calendars('AAMk__________________________________________________BGAAAAAA"\
    "CXwb______________________________________________________________QrRb40G"\
    "Y___________CAAA=')\",\"Id\":\"calendar_3\",\"Name\":\"Birthdays\",\"Co"\
    "lor\":\"Auto\",\"ChangeKey\":\"change_key_3\"}]}"
  end

  def create_event(_token, _event, _calendar_id)
    return {
      id: 'fake event',
      description: 'some description'
    }
  end
end
