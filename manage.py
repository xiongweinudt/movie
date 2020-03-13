# _*_ coding: utf-8 _*_

__author__ = 'weixiong'
__date__ = '2020/3/10'
import getpass
from app import app
from app.models import *
from flask_script import Manager
from werkzeug.security import generate_password_hash
# BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# sys.path.insert(0, os.path.join(BASE_DIR, 'movie_project\\app'))
# sys.path.insert(0, os.path.join(BASE_DIR, 'movie_project\\app\\admin'))
# sys.path.insert(0, os.path.join(BASE_DIR, 'movie_project\\app\\home'))

manager = Manager(app)


@manager.command
def initdb():
    """初始化数据表"""
    db.drop_all()
    db.create_all()
    u = User(name='test', pwd=generate_password_hash('test'), email='test@qq.com')
    db.session.add(u)
    db.session.commit()
    print("初始化数据库成功......")


@manager.command
def createsu():
    """创建超级用户"""
    username = input('请输入超级用户名: ')
    if Admin.query.filter_by(name=username).first():
        print('该超户已经存在....')
    else:
        password = getpass.getpass('请输入超级用户密码: ')
        password_hash = generate_password_hash(password)
        admin = Admin(name=username, pwd=password_hash, is_super=True)
        db.session.add(admin)
        db.session.commit()
        print('创建超级用户成功')


if __name__ == "__main__":
    manager.run()
