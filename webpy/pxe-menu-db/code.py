#!/usr/bin/python 
import web,os
from web import form

db = web.database(dbn='mysql', user='root', pw='gdcloud.com', db='pxe')
render = web.template.render("templates")

urls = (
    '/', 'index',
)

#| id | distro | releasever | basearch | dir  | kernel  | initrd | append | createdtime         |
app = web.application(urls, globals())
login = form.Form(
    form.Dropdown('branch', ['linux', 'windows']),
    form.Dropdown('distro', ['CenOS', 'Ubuntu','RHEL','Others']),
    form.Textbox('releasever'),
    form.Dropdown('basearch', ['x86_64', 'i386']),
    form.Textbox('dir'),
    form.Textbox('kernel'),
    form.Textbox('initrd'),
    form.Textbox('append'),
    form.Textarea('desc'),
    form.Radio('enable',['YES','NO']),

#    validators = [form.Validator("Passwords didn't match.", lambda i: i.password == i.password_again)]

)

class index:
    def GET(self):
        f=login()
        return render.formtest(f)
    def POST(self):
        f=login()
        if not f.validates():
            return render.formtest(f)
#| id | distro | releasever | basearch | dir  | kernel  | initrd | append | createdtime 
        else:
            n=db.insert(
		'menu',
		id="",
		dir=f['dir'].value,
		distro=f['distro'].value,
		releasever=f['releasever'].value,
		basearch=f['basearch'].value,
		kernel=f['kernel'].value,
		initrd=f['initrd'].value,
		append=f['append'].value,
		createdtime=""
		)
            distros = db.select('menu')
            return render.index(distros)
if __name__ == "__main__":
    web.internalerror = web.debugerror
    app.run()
