#!/usr/bin/env python
# coding: utf-8
import web
from config import settings

render = settings.render

menu_data = web.input()
release = menu_data.release
arch = menu_data.arch
ks = menu_data.ks

class centos:
    def GET(self,name):
        return render.centos(release,arch,ks)

class ubuntu:
    def GET(self,name):
        return render.ubuntu(release,arch,ks)

class favicon:
    def GET(self):
        return 'ok'
