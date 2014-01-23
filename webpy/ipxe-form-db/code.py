#!/usr/bin/python 
import web,os
from web import form

db = web.database(dbn='mysql', user='root', pw='gdcloud.com', db='pxe')
render = web.template.render("templates")

urls = (
    '/', 'index',
)

app = web.application(urls, globals())
login = form.Form(
    form.Textbox('mac'),
    form.Textbox('ip'),
    form.Textbox('uuid'),
)

class index:
    def GET(self):
        f=login()
        return render.formtest(f)
    def POST(self):
        f=login()
        if not f.validates():
            return render.formtest(f)
        else:
            n=db.insert(
		'ipxe',
		mac=f['mac'].value,
		ip=f['ip'].value,
		uuid=f['uuid'].value
		)
            clients = db.select('ipxe')
            return render.index(clients)
if __name__ == "__main__":
    web.internalerror = web.debugerror
    app.run()
