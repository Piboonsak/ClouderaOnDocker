## CREATE DATABASE

CREATE SCHEMA `metastore` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `amon` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `rman` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `hue` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `sentry` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `nav` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `navms` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE SCHEMA `oozie` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;


## CREATE USER
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'hive'@'%' IDENTIFIED BY 'password';
CREATE USER 'amon'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'amon'@'%' IDENTIFIED BY 'password';
CREATE USER 'rman'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'rman'@'%' IDENTIFIED BY 'password';
CREATE USER 'hue'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'hue'@'%' IDENTIFIED BY 'password';
CREATE USER 'sentry'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'sentry'@'%' IDENTIFIED BY 'password';
CREATE USER 'nav'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'nav'@'%' IDENTIFIED BY 'password';
CREATE USER 'navms'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'navms'@'%' IDENTIFIED BY 'password';
CREATE USER 'oozie'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'oozie'@'%' IDENTIFIED BY 'password';

## GRANT PRIVILEGES

GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON amon.* TO 'amon'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON amon.* TO 'amon'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON rman.* TO 'rman'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON rman.* TO 'rman'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON sentry.* TO 'sentry'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON sentry.* TO 'sentry'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nav.* TO 'nav'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nav.* TO 'nav'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON navms.* TO 'navms'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON navms.* TO 'navms'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%' IDENTIFIED BY 'password';

FLUSH PRIVILEGES;
