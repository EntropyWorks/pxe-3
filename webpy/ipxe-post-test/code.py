#!/usr/bin/python
import web        

urls = (
        "/favicon\.ico", "favicon",
         '/pxe/ipxe/(.*)', 'ipxe'
         )
app = web.application(urls, globals())
class ipxe():
    def POST(self,name):
	ipxe = web.input()
	print ipxe.global_mac,ipxe.global_ip,ipxe.global_uuid
        return 'ok'

class favicon:
    def GET(self):
        return 'ok'      

if __name__ == "__main__":
    app.run()
