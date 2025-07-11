#!/usr/bin/env python

import argparse
import os
import subprocess
import time
import signal

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# --- CLI Argument Parsing ---
parser = argparse.ArgumentParser(description='Run iCn3D interaction analysis locally.')

parser.add_argument('pdb', help='PDB ID (used for logging)')
parser.add_argument('select_first_set', help='First selection set (e.g. stru_H)')
parser.add_argument('select_second_set', help='Second selection set (e.g. stru_T)')

parser.add_argument('--headless', dest='headless', action='store_true', default=True,
                    help='Run browser in headless mode (default: True)')
parser.add_argument('--show-browser', dest='headless', action='store_false',
                    help='Disable headless mode (show browser GUI)')
parser.add_argument('--outdir', default='~/Downloads',
                    help='Output directory for downloaded files (default: ~/Downloads)')
parser.add_argument('--pdb-url', required=True,
                    help='Relative URL to the .pdb file served by your local server (e.g. /gfp_rf2/file.pdb)')
parser.add_argument('--icn3d-root', required=True,
                    help='Path to the folder containing icn3d/full.html and PDB files')

args = parser.parse_args()

# --- HTTP Server Functions ---
def start_http_server(root_dir, port=8000):
    root_dir = os.path.expanduser(root_dir)
    process = subprocess.Popen(
        ['python3', '-m', 'http.server', str(port)],
        cwd=root_dir,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        preexec_fn=os.setsid
    )
    time.sleep(2)  # Allow time for server to fully start
    return process

def stop_http_server(process):
    os.killpg(os.getpgid(process.pid), signal.SIGTERM)

# --- Browser Setup ---
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager

def configure(headless=True, download_dir='~/Downloads'):
    download_dir = os.path.expanduser(download_dir)

    options = FirefoxOptions()
    if headless:
        options.add_argument('--headless')

    options.set_preference("browser.download.folderList", 2)
    options.set_preference("browser.download.manager.showWhenStarting", False)
    options.set_preference("browser.download.dir", download_dir)
    options.set_preference("browser.helperApps.neverAsk.saveToDisk", "application/json")

    service = FirefoxService(executable_path=GeckoDriverManager().install())
    driver = webdriver.Firefox(service=service, options=options)
    return driver


# --- Element Wait Helper ---
def wait_for_element(driver, by, value, timeout=20):
    return WebDriverWait(driver, timeout).until(
        EC.presence_of_element_located((by, value))
    )

def wait_for_icn3d_viewer(driver):
    # More reliable than canvas2
    wait_for_element(driver, By.ID, "div0_analysis")

# --- iCn3D Automation ---
def del_ncbi_survey_box(driver):
    driver.implicitly_wait(10)
    try:
        for cls in [
            "QSIWebResponsiveDialog-Layout1-SI_0HhBb7Qmlxy2ZIF_content QSIWebResponsiveDialog-Layout1-SI_0HhBb7Qmlxy2ZIF_content-medium QSIWebResponsiveDialog-Layout1-SI_0HhBb7Qmlxy2ZIF_border-radius-slightly-rounded QSIWebResponsiveDialog-Layout1-SI_0HhBb7Qmlxy2ZIF_drop-shadow-medium",
            "QSIWebResponsive-creative-container-fade",
            "QSIWebResponsiveShadowBox"
        ]:
            box = driver.find_element(By.XPATH, f'//*[@class="{cls}"]')
            driver.execute_script("arguments[0].remove();", box)
    except:
        pass

def click_analysis_menu(driver):
    wait_for_element(driver, By.ID, "div0_analysis").click()

def click_interact_menu(driver):
    wait_for_element(driver, By.ID, "div0_mn6_hbondsYes").click()

def mv_cursor_combo_box(driver):
    t = wait_for_element(driver, By.XPATH, '//*[@id="div0_dl_hbonds"]')
    ActionChains(driver).move_to_element(t).click().perform()

def selection_item_setA(driver, A_item):
    xpath = f'//*[@id="div0_dl_hbonds"]/table[1]/tbody/tr/td[1]/div/div/select/option[contains(text(),"{A_item}")]'
    wait_for_element(driver, By.XPATH, xpath).click()

def selection_item_setB(driver, B_item):
    xpath = f'//*[@id="div0_dl_hbonds"]/table[1]/tbody/tr/td[2]/div/div/select/option[contains(text(),"{B_item}")]'
    wait_for_element(driver, By.XPATH, xpath).click()

def interaction_network(driver):
    wait_for_element(driver, By.ID, "div0_hbondLineGraph").click()

def click_download_file(driver, format, headless=True):
    btn_id = f'div0_linegraph_{format.lower()}'
    wait_for_element(driver, By.ID, btn_id).click()
    if not headless:
        WebDriverWait(driver, 10).until(lambda d: len(os.listdir(args.outdir)) > 0)

def load_molecule_icn3d(driver, pdb_url):
    url = f'http://localhost:8000/icn3d/full.html?type=pdb&url={pdb_url}'
    driver.get(url)
    wait_for_icn3d_viewer(driver)

# --- Main Run Logic ---
def main():
    file_format = 'json'
    server_process = start_http_server(args.icn3d_root)

    try:
        driver = configure(headless=args.headless, download_dir=args.outdir)
        load_molecule_icn3d(driver, args.pdb_url)
        del_ncbi_survey_box(driver)
        click_analysis_menu(driver)
        click_interact_menu(driver)
        mv_cursor_combo_box(driver)
        selection_item_setA(driver, args.select_first_set)
        selection_item_setB(driver, args.select_second_set)
        interaction_network(driver)
        click_download_file(driver, file_format, args.headless)
    finally:
        stop_http_server(server_process)

# --- Entrypoint ---
if __name__ == '__main__':
    main()
