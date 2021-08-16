import pyautogui
from time import sleep as sl

pyautogui.press('')
pyautogui.write('Microsoft Edge')
pyautogui.press('enter')
sl(2)
pyautogui.write('www.google.com')
pyautogui.press('enter')