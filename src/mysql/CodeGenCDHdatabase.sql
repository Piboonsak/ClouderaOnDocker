## CREATE DATABASE
CREATE SCHEMA `scm` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `amon` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `rman` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `hue` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `metastore` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `sentry` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `nav` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `navms` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `oozie` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;


## CREATE USER
CREATE USER 'root'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'root'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'scm'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'scm'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'amon'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'amon'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'rman'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'rman'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'hue'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'hue'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'hive'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'sentry'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'sentry'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'nav'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'nav'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'navms'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'navms'@'%' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'oozie'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
CREATE USER 'oozie'@'%' IDENTIFIED BY 'Cloudera01@i-net';

## GRANT PRIVILEGES
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON scm.* TO 'scm'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON scm.* TO 'scm'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON amon.* TO 'amon'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON amon.* TO 'amon'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON rman.* TO 'rman'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON rman.* TO 'rman'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON sentry.* TO 'sentry'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON sentry.* TO 'sentry'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON nav.* TO 'nav'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON nav.* TO 'nav'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON navms.* TO 'navms'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON navms.* TO 'navms'@'%' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'localhost' IDENTIFIED BY 'Cloudera01@i-net';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%' IDENTIFIED BY 'Cloudera01@i-net';

FLUSH PRIVILEGES;