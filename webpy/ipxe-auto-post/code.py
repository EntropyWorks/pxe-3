#!/usr/bin/python
import web        
from datetime import datetime

urls = (
        "/favicon\.ico", "favicon",
         '/(.*)', 'hello'
         )
app = web.application(urls, globals())

db = web.database(dbn = 'mysql', db = 'pxe', user = 'root', pw = 'gdcloud.com')
# client_ip
class hello:     
    def POST(self,name):
        ipxe = web.input()
	print ipxe.global_mac
	print ipxe.global_ip
	print ipxe.global_uuid

	db.insert('ipxe',  
          mac = ipxe.global_mac,  
          ip = ipxe.global_ip,  
          uuid = ipxe.global_uuid, 
          created = datetime.now()
	)
        return 'ok'

class favicon:
    def GET(self):
        return 'ok'      
    
if __name__ == "__main__":
    app.run()
