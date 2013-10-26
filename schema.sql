USE ctf;

CREATE TABLE IF NOT EXISTS Teams (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(32) UNIQUE,
    password VARCHAR(64),
    email VARCHAR(64),

    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Challenges (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL UNIQUE,
    category VARCHAR(32) NOT NULL,
    description VARCHAR(512) NULL,
    points INT NOT NULL,
    target VARCHAR(128) NOT NULL,
    flag VARCHAR(64) NOT NULL,
    locked BOOLEAN NOT NULL,

    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Solutions (
    t_id INT NOT NULL ,
    chal_id INT NOT NULL ,
    flag varchar(64) NULL,
    time BIGINT NOT NULL,

    PRIMARY KEY (t_id, chal_id, time),
    FOREIGN KEY (t_id) REFERENCES Teams(id),
    FOREIGN KEY (chal_id) REFERENCES Challenges(id)
);
