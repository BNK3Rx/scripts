#!/usr/bin/env
import sys
import requests
from multiprocessing.dummy import Pool

requests.urllib3.disable_warnings()

try:
    target = [i.strip() for i in open(sys.argv[1], mode='r').readlines()]
except IndexError:
    exit('noob: pd.py list.txt')

headers = {'User-Agent': 'Mozilla 5.0'}

def run(u):
    try:
        url = u + '/install.php' 
        r = requests.post(url, verify=False, headers=headers)
        if 'Drupal' in requests.get(u+'/install.php', verify=False, headers=headers).text:
            print ('\n\aDrupal:', u + '/install.php\n')
            with open('drudru.txt', mode='a') as d:
                d.write(u + '/\n')   
        else:
            print(u, " -> Not drupal")
    except:
        pass

mp = Pool(120)
mp.map(run, target)
mp.close()
mp.join()
