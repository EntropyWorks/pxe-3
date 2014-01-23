#!/usr/bin/env python
# coding: utf-8

prefix = 'controllers.'

urls = (
        "/favicon\.ico", "favicon",
         '/pxe/menu/centos/(.*)', prefix + 'menu.centos',
         '/pxe/menu/ubuntu/(.*)', prefix + 'menu.ubuntu',
         )
