import requests
import json
from jsonschema import validate
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError
import random

class StartConnection:
    def __init__(self):
        self._builtin = None

    @property
    def builtin(self):
        if not self._builtin:
            try:
                self._builtin = BuiltIn()
            except RobotNotRunningError:
                self._builtin = None
        return self._builtin

    @keyword('Establish Post Request')
    def establish_post_request(self, url: str, payload: dict = None):
        jsonPaylad = json.dumps(payload)
        resp = requests.post(url=url, json=json.loads(jsonPaylad), verify=True)
        self.builtin.set_test_variable('${RESPONSE}', resp)

    @keyword('prepare test payload')
    def prepare_test_payload(self, path: str, key: str):
        with open(path, 'r', encoding='utf-8') as of:
            json_data = json.load(of)
            payload = json_data['data'][key]
            random_int = random.randint(1, 100)
            if 'email' in payload:
                email_parts = payload['email'].split('@')
                payload['email'] = f"{email_parts[0]}+{random_int}@{email_parts[1]}"

            return payload

    @keyword('prepare payload')
    def prepare_payload(self, path: str, key: str):
        with open(path, 'r', encoding='utf-8') as of:
            json_test_data = json.load(of)
            return json_test_data['data'][key]

    @keyword('validate schema')
    def validate_schema(self, expected_resp_body: dict, resp: dict = None):
        if resp is None:
            resp = self.builtin.get_variable_value('${RESPONSE}')
            json_data = json.loads(resp.text)
        else:
            json_data = resp

        try:
            validate(instance=json_data, schema=expected_resp_body)
        except AssertionError:
            err = f'Actual Status Code is {json_data}, not {expected_resp_body} as expected. \n'
            raise AssertionError(err)

    @keyword('convert json to dictionary')
    def convert_json_to_dictionary(self, file: str = None):
        if file is not None:
            if file.endswith('.json'):
                with open(file) as of:
                    return json.load(of)
        resp = self.builtin.get_variable_value('${RESPONSE}')
        return json.loads(resp.text)




