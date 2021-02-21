import requests
import json
r=requests.get("https://get.geojs.io/")
print(r)
ip_request=requests.get("https://get.geojs.io/v1/ip.json")
ip_add=ip_request.json()['ip']
print(ip_add)

url="https://get.geojs.io/v1/ip/geo/"+ip_add+".json"
geo_request=requests.get(url)
geo_data=geo_request.json()
print(geo_data)