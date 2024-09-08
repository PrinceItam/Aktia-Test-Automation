"""
===================================================
Common Libray: Common HTTP helpers and keywords
===================================================
"""
import requests
import json
from jsonschema import validate
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError
import random

class StartConnection:
    def __init__(self):
        """
        Class initialization

        """
        self._builtin = None

    @property
    def builtin(self):
        """
        Property to get the BuiltIn library instance.

        """
        if not self._builtin:
            try:
                self._builtin = BuiltIn()
            except RobotNotRunningError:
                self._builtin = None
        return self._builtin

    @keyword('Establish Post Request')
    def establish_post_request(self, url: str, payload: dict = None):
        """
        Establishes a POST request to the given URL with the provided payload.
        :param url: The URL to send the POST request to.
        :param payload: The payload to include in the POST request.

        """
        jsonPaylad = json.dumps(payload)
        resp = requests.post(url=url, json=json.loads(jsonPaylad), verify=True)
        self.builtin.set_test_variable('${RESPONSE}', resp)

    @keyword('prepare test payload')
    def prepare_test_payload(self, path: str, key: str):
        """
        Prepares a test payload from a JSON file and modifies the email field to include a random integer.

        :param path: The path to the JSON file.
        :param key: The key to extract the payload from the JSON data.
        :return: The modified payload.

        """
        with open(path, 'r', encoding='utf-8') as of:
            json_data = json.load(of)
            payload = json_data['data'][key]
            random_int = random.randint(1, 500)
            if 'email' in payload:
                email_parts = payload['email'].split('@')
                payload['email'] = f"{email_parts[0]}+{random_int}@{email_parts[1]}"

            return payload

    @keyword('prepare payload')
    def prepare_payload(self, path: str, key: str):
        """
        Prepares a payload from a JSON file.
        :param path: The path to the JSON file.
        :param key: The key to extract the payload from the JSON data.
        :return: The payload.

        """
        with open(path, 'r', encoding='utf-8') as of:
            json_test_data = json.load(of)
            return json_test_data['data'][key]

    @keyword('validate schema')
    def validate_schema(self, expected_resp_body: dict, resp: dict = None):
        """
        Validates the response schema against the expected schema.

        :param expected_resp_body: The expected response body schema.
        :param resp: The actual response to validate. If None, uses the response stored in the test variable.

        """
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
        """
        Converts a JSON file or response to a dictionary.

        :param file: The path to the JSON file. If None, uses the response stored in the test variable.
        :return: The dictionary representation of the JSON data.

        """
        if file is not None:
            if file.endswith('.json'):
                with open(file) as of:
                    return json.load(of)
        resp = self.builtin.get_variable_value('${RESPONSE}')
        return json.loads(resp.text)




