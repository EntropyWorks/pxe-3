# -*- coding:utf-8 -*-
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import scoped_session, sessionmaker

#定义数据库的账号、端口、密码、数据库名，使用的连接模块，这里用的是mysqldb
engine = create_engine(
    'mysql+mysqldb://root:123456@localhost:3306/temp?charset=utf8',
    echo=False#是否输出数据库操作过程，很方便调试
)

#定义一个函数，用来获取sqlalchemy的session
def bindSQL():
    return scoped_session(sessionmaker(bind=engine))

Base = declarative_base()

class User(Base):
    __tablename__ = "user"
    id = Column(Integer, primary_key=True)
    name = Column(String(20), unique=True)
    email = Column(String(32), unique=True)
    password = Column(String(32))
    superuser = Column(Boolean, default=False)

metadata = Base.metadata

if __name__ == "__main__":
    metadata.create_all(engine)#运行python models.py就会自动创建定义的所有表
