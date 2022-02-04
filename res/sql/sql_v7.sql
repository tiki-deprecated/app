/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

DROP TABLE company;
DROP TABLE sender;
DROP TABLE message;

-- -----------------------------------------------------------------------
-- COMPANY
-- -----------------------------------------------------------------------
CREATE TABLE company (
     company_id INTEGER PRIMARY KEY AUTOINCREMENT,
     logo TEXT,
     security_score REAL,
     breach_score REAL,
     sensitivity_score REAL,
     domain TEXT UNIQUE,
     created_epoch INTEGER NOT NULL,
     modified_epoch INTEGER NOT NULL
);

-- -----------------------------------------------------------------------
-- SENDER
-- -----------------------------------------------------------------------
CREATE TABLE sender (
    sender_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_domain TEXT NOT NULL,
    name TEXT,
    email TEXT,
    category TEXT,
    unsubscribe_mail_to TEXT,
    ignore_until_epoch INTEGER,
    email_since_epoch INTEGER,
    updated_epoch INTEGER,
    unsubscribed_bool INTEGER,
    created_epoch INTEGER NOT NULL,
    modified_epoch INTEGER NOT NULL
);


-- -----------------------------------------------------------------------
-- MESSAGE
-- -----------------------------------------------------------------------
CREATE TABLE message (
     message_id INTEGER PRIMARY KEY AUTOINCREMENT ,
     ext_message_id TEXT NOT NULL,
     sender_email TEXT NOT NULL,
     received_date_epoch INTEGER,
     opened_date_epoch INTEGER,
     to_email TEXT NOT NULL,
     created_epoch INTEGER NOT NULL,
     modified_epoch INTEGER NOT NULL,
     UNIQUE (ext_message_id, to_email)
);