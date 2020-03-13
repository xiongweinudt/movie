/*
 Source Server         : ubuntu
 Source Server Type    : SQLite
 Source Schema         : movie

 Date: 2020/03/10 21:22:40
*/

-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS 'admin';
CREATE TABLE 'admin'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'name' varchar(100) UNIQUE DEFAULT NULL,
  'pwd' varchar(100) DEFAULT NULL,
  'is_super' smallint(6) DEFAULT NULL,
  'role_id' int(11) DEFAULT NULL,
  'addtime' datetime DEFAULT NULL,
  CONSTRAINT 'admin_ibfk_1' FOREIGN KEY ('role_id') REFERENCES 'role' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_admin' ON 'admin' (name, role_id, addtime);
-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS 'adminlog';
CREATE TABLE 'adminlog'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'admin_id' int(11) UNIQUE DEFAULT NULL,
  'ip' varchar(100) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  CONSTRAINT 'adminlog_ibfk_1' FOREIGN KEY ('admin_id') REFERENCES 'admin' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_adminlog' ON 'adminlog' (admin_id, addtime);

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS 'auth';
CREATE TABLE 'auth'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'name' varchar(100) UNIQUE DEFAULT NULL,
  'url' varchar(255) UNIQUE DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL
);

CREATE INDEX 'ix_auth' ON 'auth' (name, url, addtime);
-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS 'comment';
CREATE TABLE 'comment'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'content' text,
  'movie_id' int(11) DEFAULT NULL,
  'user_id' int(11) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  CONSTRAINT 'comment_ibfk_1' FOREIGN KEY ('movie_id') REFERENCES 'movie' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT 'comment_ibfk_2' FOREIGN KEY ('user_id') REFERENCES 'user' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_comment' ON 'comment' (movie_id, user_id, addtime);

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS 'movie';
CREATE TABLE 'movie'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'title' varchar(255) UNIQUE DEFAULT NULL,
  'url' varchar(255) UNIQUE DEFAULT NULL,
  'info' text,
  'logo' varchar(255) DEFAULT NULL,
  'star' smallint(6) DEFAULT NULL,
  'playnum' bigint(20) DEFAULT NULL,
  'commentnum' bigint(20) DEFAULT NULL,
  'tag_id' int(11) DEFAULT NULL,
  'area' varchar(255) DEFAULT NULL,
  'release_time' date DEFAULT NULL,
  'length' varchar(100) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  CONSTRAINT 'movie_ibfk_1' FOREIGN KEY ('tag_id') REFERENCES 'tag' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_movie' ON 'movie' (title, url, logo, tag_id, addtime);

-- ----------------------------
-- Table structure for moviecol
-- ----------------------------
DROP TABLE IF EXISTS 'moviecol';
CREATE TABLE 'moviecol'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'movie_id' int(11) DEFAULT NULL,
  'user_id' int(11) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  CONSTRAINT 'moviecol_ibfk_1' FOREIGN KEY ('movie_id') REFERENCES 'movie' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT 'moviecol_ibfk_2' FOREIGN KEY ('user_id') REFERENCES 'user' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_moviecol' ON 'moviecol' (movie_id, user_id, addtime);

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS 'oplog';
CREATE TABLE 'oplog'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'admin_id' int(11) DEFAULT NULL,
  'ip' varchar(100) DEFAULT NULL,
  'reason' varchar(600) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  CONSTRAINT 'oplog_ibfk_1' FOREIGN KEY ('admin_id') REFERENCES 'admin' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_oplog' ON 'oplog' (admin_id, addtime);

-- ----------------------------
-- Table structure for preview
-- ----------------------------
DROP TABLE IF EXISTS 'preview';
CREATE TABLE 'preview'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'title' varchar(255) UNIQUE DEFAULT NULL,
  'logo' varchar(255) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL
);

CREATE INDEX 'ix_preview' ON 'preview' (title, logo, addtime);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS 'role';
CREATE TABLE 'role'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'name' varchar(100) UNIQUE DEFAULT NULL,
  'auths' varchar(600) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL
);

CREATE INDEX 'ix_role' ON 'role' (name, addtime);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS 'tag';
CREATE TABLE 'tag'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'name' varchar(100) UNIQUE DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL
) ;

CREATE INDEX 'ix_tag' ON 'tag' (name, addtime);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS 'user';
CREATE TABLE 'user'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'name' varchar(100) UNIQUE DEFAULT NULL,
  'pwd' varchar(100) DEFAULT NULL,
  'email' varchar(100) UNIQUE DEFAULT NULL,
  'phone' varchar(11) UNIQUE DEFAULT NULL,
  'info' text,
  'face' varchar(255) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  'uuid' varchar(255) UNIQUE DEFAULT NULL
);

CREATE INDEX 'ix_user' ON 'user' (name, email, phone, face, uuid, addtime);

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS 'userlog';
CREATE TABLE 'userlog'  (
  'id' integer PRIMARY KEY AUTOINCREMENT,
  'user_id' int(11) DEFAULT NULL,
  'ip' varchar(100) DEFAULT NULL,
  'addtime' datetime(0) DEFAULT NULL,
  CONSTRAINT 'userlog_ibfk_1' FOREIGN KEY ('user_id') REFERENCES 'user' ('id') ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX 'ix_userlog' ON 'userlog' (user_id, addtime);
