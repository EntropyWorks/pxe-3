#!/usr/bin/env python
# coding: utf-8
import web

web.config.debug = True

render = web.template.render('templates')
config = web.storage(
    server='192.168.11.9',
    ks_path = 'pxe/linux/ks',
)

web.template.Template.globals['config'] = config
web.template.Template.globals['render'] = render
