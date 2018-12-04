#!/usr/bin/python3

import time
import yaml
from selenium import webdriver

credentials = yaml.safe_load(open('credentials.yaml', 'r'))

driver = webdriver.Chrome('/usr/bin/chromedriver')
driver.get('https://www.vodafone.it/area-utente/fai-da-te/Common/PaginaUnicadiLogin.html#')
assert 'Smartphone, Internet, telefoni cellulari, telefoni' in driver.title

username_field = driver.find_element_by_name('username')
username_field.send_keys(credentials['vodafone_user'])

password_field = driver.find_element_by_name('password')
password_field.send_keys(credentials['vodafone_password'])

submit_button = driver.find_element_by_tag_name('button')
submit_button.click()

time.sleep(4)
residual = driver.find_element_by_id('rzf_increment-value-0-0-0')
print(residual.text)

driver.quit()

# More advanced stuff
# cookies_list = driver.get_cookies()
# cookies_dict = {}
# print(cookies_list)
# for cookie in cookies_list:
    # cookies_dict[cookie['name']] = cookie['value']

# print(cookies_dict)
# # session_id = cookies_dict.get('session')
# # print(session_id)



# from selenium.webdriver.common.by import By
# from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.support import expected_conditions as EC
# WebDriverWait(driver, 10).until(EC.frame_to_be_available_and_switch_to_it((By.ID, 'rzf_increment-value-0-0-0')))
