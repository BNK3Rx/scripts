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
        url = u + '/misc/drupal.js' 
        if 'Drupal' in requests.get(u+'/misc/drupal.js', verify=False, headers=headers).text:
            print ('\n\aDrupal:', u + '/misc/drupal.js\n')
            with open('drudru2.txt', mode='a') as d:
                d.write(u + '/\n')   
        else:
            print(u, " -> Not drupal")
    except:
        pass

mp = Pool(120)
mp.map(run, target)
mp.close()
mp.join()
